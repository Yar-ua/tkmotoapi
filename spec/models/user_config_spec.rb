require 'rails_helper'

RSpec.describe UserConfig, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @user_config = FactoryBot.create(:user_config, :user => @user)
  end
  
  it 'user config after Factory valid' do
    expect(@user_config).to be_valid
  end

  describe 'user.config must have all important attributes' do
    it { expect(@user_config.language).to be}
  end

  it 'invalid with invalid attributes' do
    @user_config.language = ''
    expect(@user_config).to be_invalid
  end
end
