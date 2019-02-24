require 'rails_helper'

RSpec.describe FuelsController, type: :controller do

  describe "access to fuels pathes" do
    before do
    @user = FactoryBot.create(:user)
    @bike = FactoryBot.create(:bike, user: @user)
    end

    it "fuel index permitted for all users" do
      get :index, params: {bike_id: @bike.id}
      expect(response.status).to eq(200)
    end
    
    it "all other fuel pathes forbidden for unauthorized users" do
      post :create, params: {bike_id: @bike.id}
      expect(response.status).to eq(401)
      get :show, params: {bike_id: @bike.id, id: 1}
      expect(response.status).to eq(401)
      put :update, params: {bike_id: @bike.id, id: 1}
      expect(response.status).to eq(401)
      delete :destroy, params: {bike_id: @bike.id, id: 1}
      expect(response.status).to eq(401)
    end

    describe "testing fuel :index" do
      it "test fuel :index page" do
        get :index, params: {bike_id: @bike.id}
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")
      end
    end

    describe "testing :create fuel" do
      before do
        @another_user = FactoryBot.create(:user)
        @another_bike = FactoryBot.create(:bike, user: @another_user)
        @fuel = FactoryBot.attributes_for(:fuel, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end

      it "forbidden if current user is not bike owner" do
        post :create, params: {bike_id: @another_bike.id, fuel: @fuel}
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('Forbidden - you are not bike owner')
      end

      it 'error 404 if bike not found by ID' do
        post :create, params: { bike_id: 999999, fuel: @fuel }
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Bike not found')
      end

      it "can\'t be created with incorrect values" do
        @new_fuel = @fuel
        @new_fuel[:distance] = 'a21'
        post :create, params: {bike_id: @bike.id, fuel: @new_fuel}
        expect(response.status).to eq(422)
        expect(@bike.fuels.count).to eq(0)
      end

      it "can be created with correct parameters" do
        post :create, params: { bike_id: @bike.id, fuel: @fuel }
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")
        expect(@bike.fuels.count).to eq(1)
      end
    end

    describe 'test :show page' do
      it 'response 200 with data' do
        request.headers.merge! @user.create_new_auth_token
        @new_fuel = FactoryBot.create(:fuel, bike: @bike)
        get :show, params: { bike_id: @bike.id, id: @new_fuel.id}
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")
      end
    end

    describe 'test :update route' do
      before do
        @new_fuel = FactoryBot.create(:fuel, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'forbidden if bike or fuel not found' do
        put :update, params: {bike_id: 99999, id: @new_fuel.id, fuel: @new_fuel}
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Bike not found')
        put :update, params: {bike_id: @bike.id, id: 888888888, fuel: @new_fuel}
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Fuel\'s data not found')
      end

      it 'forbidden if you are not bike owner' do
        @another_user = FactoryBot.create(:user)
        request.headers.merge! @another_user.create_new_auth_token
        put :update, params: {bike_id: @bike.id, id: @new_fuel.id, fuel: @new_fuel}
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('Forbidden operation - You are not bike owner')
      end

      it 'successfully updated with right parameters' do
        @fuel = FactoryBot.attributes_for(:fuel, bike: @bike)
        put :update, params: {bike_id: @bike.id, id: @new_fuel.id, fuel: @fuel}
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")
      end
    end

    describe 'test :destroy route' do
      before do
        @new_fuel = FactoryBot.create(:fuel, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'forbidden if you are not bike owner' do
        @another_user = FactoryBot.create(:user)
        request.headers.merge! @another_user.create_new_auth_token
        delete :destroy, params: {bike_id: @bike.id, id: @new_fuel.id}
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('Forbidden operation - You are not bike owner')
      end

      it 'fuel data can be deleted' do
        delete :destroy, params: {bike_id: @bike.id, id: @new_fuel.id}
        expect(response.status).to eq(200)
        expect( JSON.parse(response.body)["alerts"]["success"] ).to eq('Fuel was deleted')
      end
    end

  end
end
