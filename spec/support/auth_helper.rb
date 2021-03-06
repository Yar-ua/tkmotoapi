module AuthHelper
  
  def authenticate_user user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.headers.merge! user.create_new_auth_token
    sign_in user
  end

  def login_user
    @user = FactoryBot.create(:user)
    request.headers.merge! @user.create_new_auth_token
  end
  
end