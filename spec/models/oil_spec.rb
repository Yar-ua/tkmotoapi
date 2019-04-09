require 'rails_helper'

RSpec.describe Oil, type: :model do
  let(:user) {FactoryBot.create(:user)}
  let(:bike) {FactoryBot.create(:bike, :user => user)}
  let(:oil) {FactoryBot.create(:oil, :bike => bike)}

  it 'bike after Factory valid with valid attributes' do
    expect(bike).to be_valid
  end

  it 'oil after Factory valid with valid attributes' do
    expect(oil).to be_valid
  end

  describe 'fuel must have all important attributes' do
    it { expect(:oil_distance).to be}
  end  
end
