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

  def oil_params
    params.require(:oil).permit(:oil_distance)
  end

end
