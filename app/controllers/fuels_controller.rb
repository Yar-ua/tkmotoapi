class FuelsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_bike
  before_action :set_fuel, only: [:show, :update, :destroy]

  def index
    @fuels = Fuel.where(bike_id: @bike.id).order(created_at: :desc)
    send_response(@fuels, 200)
  end

  def create
    if current_user_is_bike_owner
      @fuel = @bike.fuels.build(fuel_params)
      if @fuel.save
        send_response(@fuel, 200, [success: 'Fuel stata successfully created'])
      else
        send_response(nil, 422, nil, @fuel.errors)
      end
    else
      send_response(nil, 422, nil, 'Forbidden - you are not bike owner to create a fuel stata')
    end
  end

  def show
    send_response(@fuel)
  end

  def update
  end

  def destroy
  end



  private

  def set_bike
    @bike = Bike.find(params[:bike_id])
    rescue ActiveRecord::RecordNotFound
      send_response(nil, 404, nil, ['Bike not found'])
    return @bike
  end

  def set_fuel
    @fuel = Fuel.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      send_response(nil, 404, nil, ['Fuel\'s data not found'])
    return @bike
  end

  def current_user_is_bike_owner
    return true if current_user.id == @bike.user_id
    # if current_user.id == @bike.user_id
    #   return true
    # else
    #   return false
    # end
  end

end
