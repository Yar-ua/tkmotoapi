require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validate email uniqueness' do
    user = FactoryBot.create(:user, email: 'foo@bar.com')
    user = User.new attributes_for(:user, email: 'foo@bar.com')
    expect(user).to be_invalid
  end

  it 'validate name uniqueness' do
    user = FactoryBot.create(:user, name: '111')
    user = User.new attributes_for(:user, name: '111')
    expect(user).to be_invalid
  end

  it 'user invalid when some attributes is missing' do
    user_attrs = attributes_for(:user).except(:name)
    user = User.new user_attrs
    expect(user).to be_invalid
  end

end