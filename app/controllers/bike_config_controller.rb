class BikeConfigController < ApplicationController
  before_action :authenticate_user!, except: :show

  before_action :set_bike
  before_action :set_bike_config

  def show
    send_response(@bike_config, 200)
  end

  def update
    if current_user_is_bike_owner
      if @bike_config.update_attributes(bike_config_params)
        send_response(@bike_config, 200, [success: 'Config successfully saved'])
      else
        send_response(nil, 403, nil, @bike_config.errors)
      end
    else
      error_not_bike_owner
    end   
  end

  private

  def set_bike_config
    if @bike.bike_config == nil
      create_default_config
    else 
      @bike_config = @bike.bike_config
    end
  end

  def bike_config_params
    params.require(:bike_config).permit(:oil_change)
  end

  def create_default_config
    default_config = BikeConfig.create(bike_id: @bike.id, oil_change: 0)
    @bike_config = default_config
  end
end
