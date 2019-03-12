require 'rails_helper'

RSpec.describe Fuel, type: :model do
  let(:user) {FactoryBot.create(:user)}
  let(:bike) {FactoryBot.create(:bike, :user => user)}
  let(:fuel) {FactoryBot.create(:fuel, :bike => bike)}

  it 'bike after Factory valid with valid attributes' do
    expect(bike).to be_valid
  end

  it 'fuel after Factory valid with valid attributes' do
    expect(fuel).to be_valid
  end

  describe 'fuel must have all important attributes' do
    it { expect(:odometer).to be}
    it { expect(:distance).to be}
    it { expect(:refueling).to be}
    it { expect(:price_fuel).to be}
  end  
end
