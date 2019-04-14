5.times do
  user = FactoryBot.create(:user)
  3.times do
    bike = FactoryBot.create(:bike, user: user)
    FactoryBot.create(:bike_config, bike: bike)
    10.times do
      FactoryBot.create(:fuel, bike: bike)
    end
    FactoryBot.create(:oil, bike: bike)
    10.times do
      FactoryBot.create(:fuel, bike: bike)
    end
    FactoryBot.create(:oil, bike: bike)
    7.times do
      FactoryBot.create(:fuel, bike: bike)
    end
    15.times do
      FactoryBot.create(:repair, bike: bike)
    end
    3.times do
      FactoryBot.create(:oil, bike: bike)
    end
  end
end