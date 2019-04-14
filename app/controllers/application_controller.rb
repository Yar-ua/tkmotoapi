class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  # send response JSON
  def send_response(data, status = 200, alerts = [], errors = [])
    response = [
      data: data,
      alerts: alerts,
      errors: errors
    ]
    render status: status, json: response[0].to_json
  end

  def set_bike
    @bike = Bike.find(params[:bike_id])
    rescue ActiveRecord::RecordNotFound
      send_response(nil, 404, nil, 'Bike not found')
    return @bike
  end

  def error_not_bike_owner
    send_response(nil, 422, nil, 'Forbidden - You are not bike owner')
  end

  def current_user_is_bike_owner
    return true if current_user.id == @bike.user_id
  end
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
