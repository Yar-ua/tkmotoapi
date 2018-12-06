require 'rails_helper'

RSpec.describe BikesController, type: :controller do

  it 'forbidden for unregistred users' do
    get :index
    expect(response.status).to eq(401)
    post :create
    expect(response.status).to eq(401)
  end
end
