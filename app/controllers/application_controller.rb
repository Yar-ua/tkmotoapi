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

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
