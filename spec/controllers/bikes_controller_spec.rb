require 'rails_helper'

RSpec.describe BikesController, type: :controller do

  it 'forbidden for unregistred users' do
    get :index
    expect(response.status).to eq(401)
    post :create
    expect(response.status).to eq(401)
    get :show, params: {id: 1}
    expect(response.status).to eq(401)
    put :update, params: {id: 1}
    expect(response.status).to eq(401)
    delete :destroy, params: {id: 1}
    expect(response.status).to eq(401)
  end

  describe 'when user authenticated' do
    describe 'testing Creat, Read' do
      before do
        @user = FactoryBot.create(:user)
        @bike = FactoryBot.attributes_for(:bike, user: @user)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'get index page' do
        get :index
        expect(response.status).to eq(200)
      end

      it 'create bike' do
        post :create, params: @bike
        expect(response.status).to eq(200)
        expect(@user.bikes.count).to be > 0
      end
    end

    describe 'testing Show Update Delete' do
      before do
        @user = FactoryBot.create(:user)
        @another_user = FactoryBot.create(:user)
        @bike = FactoryBot.create(:bike, user: @user)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'show bike' do
        get :show, params: {id: @bike.id}
        expect(response.status).to eq(200)
        expect(response.body).to eq(@bike.to_json)
      end

      it 'update bike forbidden if user is not bike owner' do
        request.headers.merge! @another_user.create_new_auth_token
        @new_name = 'Yamaha KLX'
        put :update, params: {id: @bike.id, name: @new_name}
        expect(response.status).to eq(422)
      end

      it 'update bike' do
        @new_name = 'Yamaha KLX'
        put :update, params: {id: @bike.id, name: @new_name}
        expect(response.status).to eq(200)
        expect(Bike.find(@bike.id)[:name]).to eq(@new_name)
      end

      it 'destroy bike forbidden if user is not bike owner' do
        request.headers.merge! @another_user.create_new_auth_token
        delete :destroy, params: {id: @bike.id}
        expect(response.status).to eq(422)
        expect(Bike.exists?(@bike.id)).to be true
      end

      it 'destroy bike' do
        delete :destroy, params: {id: @bike.id}
        expect(response.status).to eq(200)
        expect(Bike.exists?(@bike.id)).to be false
      end

    end
  end


end
