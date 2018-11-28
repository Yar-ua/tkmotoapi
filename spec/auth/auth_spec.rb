require "rails_helper"

# Resource: https://github.com/lynndylanhurley/devise_token_auth/issues/75#issuecomment-258496229

# initialise constant for using in reset and change password
RAW_TOKEN, HASHED_TOKEN = Devise.token_generator.generate(User, :reset_password_token)

RSpec.describe "Auth", :type => :request do
  before do
    @user = FactoryBot.attributes_for(:user)
    @sign_in_params = {
      email: @user[:email],
      password: @user[:password]
    }
    @registration_params = {
      name: @user[:name],
      email: @user[:email],
      password: @user[:password]
    }
  end

  describe 'Testing access to resourses' do
    it 'Access to free resource' do
      get root_path
      expect(response.status).to eq(200)
      get about_path
      expect(response.status).to eq(200)
    end

    it 'Resource forbidden, if user not authenticated' do
      get secure_path
      expect(response.status).to eq(401)
    end
  end

  describe 'Testing registration: POST /auth' do
    it 'should respond with 200 OK' do
      registration
      expect(response.status).to eq(200)
      expect change(User, :count).by(1)
    end
 end

  describe 'Testing confirm registration: GET /auth/confirmation' do
    before do
      registration
    end

    it 'should respond with 301 REDIRECTION' do
      register_confirmation
      expect(response).to be_redirect
    end
  end

  describe 'Testing login: POST /auth/sign_in' do
    before do
      registration
      register_confirmation
      sign_in
      @auth_params = get_auth_params_from_login_response_headers(response)
    end

    it 'should respond with 200 OK' do
      expect(response.status).to eq(200)
    end

    it 'After sign_in it should have in response header "access-token", "uid", "client"' do
      expect(response.has_header?('access-token')).to eq(true)
      expect(response.has_header?('uid')).to eq(true)
      expect(response.has_header?('client')).to eq(true)
    end

    it 'Loginned user has rights to all resources' do
      get secure_path, headers: @auth_params
      expect(response.status).to eq(200)
    end

    it 'Resources forbidden for incorrect token' do
      @auth_params['access-token'] = 123123
      get secure_path, headers: @auth_params
      expect(response.status).to eq(401)
    end

    describe 'Testing sign_out: DELETE /auth/sign_out' do
      it 'sign_out must be succsessful' do
        delete destroy_user_session_path, headers: @auth_params
        expect(response.status).to eq(200)
        expect(response.body).to eq('{"success":true}')
      end
    end
  end

  describe 'Testing reset password' do
    before do
      registration
      register_confirmation
      sign_in
      @auth_params = get_auth_params_from_login_response_headers(response)
      post user_password_path(email: @registration_params[:email], 
          redirect_url: 'auth/password/edit', headers: @auth_params)
    end

    it 'password reset response should be 200 ok' do
      expect(response.status).to eq(200)
    end

    describe 'confirmation reset password' do
      before do
        reset_password
      end

      it 'should be successfully' do
        expect(response.status).to eq(302)
      end

      it 'password can be changed after reset' do
        sign_in
        @auth_params = get_auth_params_from_login_response_headers(response)
        put user_password_path(password: '22334455', password_confirmation: '22334455'),
            headers: @auth_params
        expect(response.status).to eq(200)
      end
    end
  end


  # # helper to get headers params
  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    auth_params = {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token_type' => token_type
    }
    return auth_params
  end

  def sign_in
    post user_session_path, params: @sign_in_params
  end

  def registration
    post user_registration_path, params: @registration_params
  end

  def register_confirmation
    user = User.last
    get user_confirmation_path(:config => 'default', 
      :confirmation_token => user.confirmation_token, :redirect_url => '/')
  end

  def reset_password
    @user = create(:user, reset_password_token: HASHED_TOKEN, reset_password_sent_at: Time.current)
    get edit_user_password_path(:config => 'default', :reset_password_token => RAW_TOKEN, 
        redirect_url: 'auth/password/edit')
  end

end

