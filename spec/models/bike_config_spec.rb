require 'rails_helper'

RSpec.describe BikeConfig, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @bike = FactoryBot.create(:bike, :user => @user)
    @bike_config = FactoryBot.create(:bike_config, :bike => @bike)
  end
  
  it 'bike config after Factory valid' do
    expect(@bike_config).to be_valid
  end

  describe 'bike config must have all important attributes' do
    it { expect(@bike_config.oil_change).to be}
  end

  it 'invalid with invalid attributes' do
    @bike_config.oil_change = 'asdasd'
    expect(@bike_config).to be_invalid
  end
end
