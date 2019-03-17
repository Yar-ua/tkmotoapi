class UserConfigController < ApplicationController
  before_action :authenticate_user!

  before_action :set_user_config

  def show
    send_response(@user_config, 200)
  end

  def update
    if @user_config.update_attributes(user_config_params)
      send_response(@user_config, 200, [success: 'Config saved'])
    else
      send_response(nil, 403, nil, @user_config.errors)
    end
  end

  private

  def set_user_config
    if @current_user.user_config == nil
      create_default_config
    else 
      @user_config = @current_user.user_config
    end
  end

  def user_config_params
    params.require(:user_config).permit(:language)
  end

  def create_default_config
    default_config = UserConfig.create(user_id: current_user.id, language: 'en')
    @user_config = default_config
  end
end
