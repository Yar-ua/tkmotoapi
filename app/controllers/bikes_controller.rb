class BikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bike, only: [:show, :update, :destroy]

  def index
    @bikes = Bike.all
    send_response(@bikes)
  end


  def create
    @bike = current_user.bikes.build(bike_params)
    if @bike.save
      send_response(@bike)
    else
      send_response(@bike.errors, 422)
    end
  end


  def show
    if @bike
      send_response(@bike)
    else
      send_response('Bike not found', 404)
    end
  end


  def update
    if (@bike.user.id == current_user.id)
      if @bike.update(bike_params)
        send_response(@bike)
      else
        send_response(@bike.errors, 403)
      end
    else
      send_response('Forbidden operation - You are not bike owner', 422)
    end    
  end


  def destroy
    if (@bike.user.id == current_user.id)
      @bike.destroy
      send_response('Bike successfully deleted')
    else
      send_response('Forbidden - You are not bike owner', 422)
    end   
  end


  private

  def bike_params
    params.permit(:name, :volume, :year, :colour)
  end

  def set_bike
    @bike = Bike.find(params[:id])
  end

end
