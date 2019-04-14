class OilsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_bike

  def index
  	send_response(@bike.oils, 200)
  end

  def oillast
    send_response(@bike.oils.maximum(:oil_distance), 200)
  end

  def create
  	if current_user_is_bike_owner
      @oil = @bike.oils.build(oil_params)
      if @bike.save
        send_response(@oil, 200, [success: 'Oil change successfully created'])
      else
        send_response(nil, 422, nil, @oil.errors)
      end
    else
      error_not_bike_owner
    end
  end

  private

  def set_bike
    @bike = Bike.find(params[:bike_id])
    rescue ActiveRecord::RecordNotFound
      send_response(nil, 404, nil, 'Bike not found')
    return @bike
  end

  def current_user_is_bike_owner
    return true if current_user.id == @bike.user_id
  end

  def error_not_bike_owner
    send_response(nil, 422, nil, 'Forbidden - You are not bike owner')
  end

  def oil_params
    params.require(:oil).permit(:oil_distance)
  end

end
