class UserConfigController < ApplicationController
  before_action :authenticate_user!

  before_action :set_user_config

  def show
    send_response(@user_config, 200)
  end

  def update
    if @user_config.update_attributes(user_config_params)
      send_response(@user_config, 200, [success: 'Repair successfully updated'])
    else
      send_response(nil, 403, nil, @user_config.errors)
    end
  end

  private

  def set_user_config
    @user_config = current_user.user_config
  end

  def user_config_params
    params.require(:user_config).permit(:language)
  end
end
