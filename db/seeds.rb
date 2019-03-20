5.times do
  user = FactoryBot.create(:user)
  3.times do
    bike = FactoryBot.create(:bike, user: user)
    FactoryBot.create(:bike_config, bike: bike)
    27.times do
      FactoryBot.create(:fuel, bike: bike)
    end
    15.times do
      FactoryBot.create(:repair, bike: bike)
    end
  end
end