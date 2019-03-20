require 'rails_helper'

RSpec.describe UserConfigController, type: :controller do

  it "all config pathes forbidden for unauthorized users" do
    get :show
    expect(response.status).to eq(401)
    put :update, params: {user_config: []}
    expect(response.status).to eq(401)
  end

  describe "test show of user config" do
    before do
      @user = FactoryBot.create(:user)
      @user_config = FactoryBot.create(:user_config, user: @user)
      request.headers.merge! @user.create_new_auth_token
    end

    it 'can be shown' do
      get :show
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
      expect(JSON.parse(response.body)['data']['language']).to eq(@user_config.language)
    end
  end

  describe "by default - if config not exists, it will be create" do
    before do
      @user = FactoryBot.create(:user)
      request.headers.merge! @user.create_new_auth_token
    end

    it 'check what it will be create' do
      get :show
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['data']['language']).to be
      expect(JSON.parse(response.body)['data']['language']).to eq('en')
    end
  end

  describe "test update of user config" do
    before do
      @user = FactoryBot.create(:user)
      @user_config = FactoryBot.create(:user_config, user: @user)
      @new_user_config = FactoryBot.attributes_for(:user_config, user: @user)
      request.headers.merge! @user.create_new_auth_token
    end

    it 'can be updated with correct values' do
      @user_config.language = 'fr'
      put :update, params: {user_config: @new_user_config}
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
    end
  end


end
