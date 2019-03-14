class BikeConfigController < ApplicationController
  before_action :authenticate_user!

  before_action :set_bike
  before_action :set_bike_config

  def show
    send_response(@bike_config, 200)
  end

  def update
    if current_user_is_bike_owner
      if @bike_config.update_attributes(bike_config_params)
        send_response(@user_config, 200, [success: 'Config successfully updated'])
      else
        send_response(nil, 403, nil, @bike_config.errors)
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

  def set_bike_config
    @bike_config = @bike.bike_config
  end

  def bike_config_params
    params.require(:bike_config).permit(:oil_change)
  end

  def current_user_is_bike_owner
    return true if current_user.id == @bike.user_id
  end

  def error_not_bike_owner
    send_response(nil, 422, nil, 'Forbidden - You are not bike owner')
  end

end
