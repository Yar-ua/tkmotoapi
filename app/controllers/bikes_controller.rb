class BikesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_bike, only: [:show, :update, :destroy]

  def index
    @bikes = Bike.all.order(id: :desc)
    send_response(@bikes, 200)
  end


  def create
    @bike = current_user.bikes.build(bike_params)
    if @bike.save
      send_response(@bike, 200, [success: 'Bike successfully created'])
    else
      send_response(nil, 422, nil, @bike.errors)
    end
  end


  def show
    if @bike
      send_response(@bike)
    else
      send_response(nil, 404, nil, 'Bike not found')
    end
  end


  def update
    if (@bike.user.id == current_user.id)
      if @bike.update(bike_params)
        send_response(@bike, 200, [success: 'Buke successfully updated'])
      else
        send_response(nil, 403, nil, @bike.errors)
      end
    else
      send_response(nil, 422, nil, 'Forbidden operation - You are not bike owner')
    end    
  end


  def destroy
    if (@bike.user.id == current_user.id)
      @bike.destroy
      send_response(nil, 200, [success: 'Bike successfully deleted'])
    else
      send_response(nil, 422, nil, 'Forbidden - You are not bike owner')
    end   
  end


  private

  def bike_params
    params.permit(:name, :volume, :year, :color)
  end

  def set_bike
    @bike = Bike.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      send_response(nil, 404, nil, ['Bike not found'])
    return @bike
  end

end
