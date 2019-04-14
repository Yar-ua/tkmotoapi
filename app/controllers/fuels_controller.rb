class FuelsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :fuellast]
  before_action :set_bike
  before_action :set_fuel, only: [:show, :update, :destroy]

  def index
    @fuels = Fuel.where(bike_id: @bike.id).order(odometer: :desc)
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
      error_not_bike_owner
    end
  end

  def fuellast
    send_response(@bike.fuels.maximum(:odometer), 200)
  end

  def update
    if current_user_is_bike_owner
      if @fuel.update(fuel_params)
        send_response(@fuel, 200, [success: 'Fuel successfully updated'])
      else
        send_response(nil, 403, nil, @fuel.errors)
      end
    else
      error_not_bike_owner
    end   
  end

  def destroy
    if current_user_is_bike_owner
      if @fuel.destroy
        send_response(nil, 200, [success: 'Fuel was deleted'])
      else
        send_response(nil, 422, nil, @fuel.errors)
      end
    else
      error_not_bike_owner
    end
  end


  private

  def fuel_params
    params.require(:fuel).permit(:odometer, :distance, :refueling, :price_fuel)
  end

  def set_bike
    @bike = Bike.find(params[:bike_id])
    rescue ActiveRecord::RecordNotFound
      send_response(nil, 404, nil, 'Bike not found')
    return @bike
  end

  def set_fuel
    @fuel = Fuel.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      send_response(nil, 404, nil, 'Fuel\'s data not found')
    return @bike
  end

  def current_user_is_bike_owner
    return true if current_user.id == @bike.user_id
  end

  def error_not_bike_owner
    send_response(nil, 422, nil, 'Forbidden - You are not bike owner')
  end

end
