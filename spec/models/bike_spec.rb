require 'rails_helper'

RSpec.describe Bike, type: :model do

  let(:user) {FactoryBot.create(:user)}
  let(:bike) {FactoryBot.create(:bike, :user => user)}

  it 'user after Factory valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'bike after Factory valid with valid attributes' do
    expect(bike).to be_valid
  end

  subject { lot }

  describe 'bike must have all important attributes' do
    it { expect(:name).to be}
    it { expect(:volume).to be}
    it { expect(:year).to be}
    it { expect(:colour).to be}
  end

end