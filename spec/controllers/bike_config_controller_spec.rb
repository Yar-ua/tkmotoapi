require 'rails_helper'

RSpec.describe BikeConfigController, type: :controller do
  describe 'testing bike configs' do
    before do
      @user = FactoryBot.create(:user)
      @bike = FactoryBot.create(:bike, user: @user)
      @bike_config = FactoryBot.create(:bike_config, bike: @bike)
    end

    it "show bike config paths permitted for unauthorized users" do
      get :show, params: {bike_id: @bike.id}
      expect(response.status).to eq(200)
    end

    it "update bike config paths forbidden for unauthorized users" do
      put :update, params: {bike_id: @bike.id}
      expect(response.status).to eq(401)
    end

    describe "by default - if config not exists, it will be create" do
      before do
        request.headers.merge! @user.create_new_auth_token
        @new_bike = FactoryBot.create(:bike, user: @user)
      end

      it 'check what it will be create' do
        get :show, params: {bike_id: @new_bike.id}
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['data']['oil_change']).to be
      end
    end

    describe "test show of bike config" do
      before do
        request.headers.merge! @user.create_new_auth_token
      end

      it 'error if bike not found' do
        get :show, params: {bike_id: 99999}
        expect(response.status).to eq(404)
      end

      it 'can be shown' do
        get :show, params: {bike_id: @bike.id}
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)['data']['oil_change']).to be(@bike_config.oil_change)
      end
    end

    describe "test update of bike config" do
      before do
        @new_bike_config = FactoryBot.attributes_for(:bike_config, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'update forbidden for not owners' do
        @another_user = FactoryBot.create(:user)
        request.headers.merge! @another_user.create_new_auth_token
        @bike_config.oil_change = 2000
        put :update, params: {bike_id: @bike.id, bike_config: @new_bike_config}
        expect(response.status).to eq(422)
      end

      it 'can be updated with correct values' do
        @bike_config.oil_change = 2000
        put :update, params: {bike_id: @bike.id, bike_config: @new_bike_config}
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")
      end
    end

  end

end
