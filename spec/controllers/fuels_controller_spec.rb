require 'rails_helper'

RSpec.describe FuelsController, type: :controller do

  describe "access to fuels pathes" do
    before do
      @user = FactoryBot.create(:user)
      @bike = FactoryBot.create(:bike, user: @user)
      @fuel = FactoryBot.create(:fuel, bike: @bike)
    end

    it "fuel index permitted for all users" do
      get :index, params: {bike_id: @bike.id}
      expect(response.status).to eq(200)
    end
    it "all other fuel pathes forbidden for unauthorized users" do
      post :create, params: {bike_id: @bike.id}
      expect(response.status).to eq(401)
      get :show, params: {bike_id: @bike.id, id: @fuel.id}
      expect(response.status).to eq(401)
      put :update, params: {bike_id: @bike.id, id: @fuel.id}
      expect(response.status).to eq(401)
      delete :destroy, params: {bike_id: @bike.id, id: @fuel.id}
      expect(response.status).to eq(401)
    end
  end

  # describe "GET #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
