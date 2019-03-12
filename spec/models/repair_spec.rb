require 'rails_helper'

RSpec.describe Repair, type: :model do
  let(:user) {FactoryBot.create(:user)}
  let(:bike) {FactoryBot.create(:bike, :user => user)}
  let(:repair) {FactoryBot.create(:repair, :bike => bike)}

  it 'bike after Factory valid with valid attributes' do
    expect(bike).to be_valid
  end

  it 'fuel after Factory valid with valid attributes' do
    expect(repair).to be_valid
  end

  describe 'fuel must have all important attributes' do
    it { expect(:description).to be}
    it { expect(:detail).to be}
    it { expect(:price_detail).to be}
  end  
end
