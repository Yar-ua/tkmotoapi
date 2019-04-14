require 'rails_helper'

RSpec.describe OilsController, type: :controller do

  describe 'testing oils' do
    before do
      @user = FactoryBot.create(:user)
      @bike = FactoryBot.create(:bike, user: @user)
      @oil = FactoryBot.create(:oil, bike: @bike)
    end

    it "index oil paths permitted for unauthorized users" do
      get :index, params: {bike_id: @bike.id}
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
    end

    it "oillast can be shown" do
      get :oillast, params: {bike_id: @bike.id}
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
      expect(JSON.parse(response.body)['data']).to eq(Oil.maximum(:oil_distance))
    end

    it "create oil paths forbidden for unauthorized users" do
      put :create, params: {bike_id: @bike.id, oil: @oil}
      expect(response.status).to eq(401)
    end


    describe "test create oil by authorized user" do
      before do
        request.headers.merge! @user.create_new_auth_token
        @new_oil = FactoryBot.attributes_for(:oil, bike: @bike)
      end

      it 'error if bike not found' do
        post :create, params: {bike_id: 99999}
        expect(response.status).to eq(404)
      end

      it 'can be create' do
        post :create, params: {bike_id: @bike.id, oil: @new_oil}
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")

        expect(JSON.parse(response.body)['data']['oil_distance']).to be(@bike.oils.last.oil_distance)
      end
    end

  end

end
