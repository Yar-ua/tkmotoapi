5.times do
  user = FactoryBot.create(:user)
  3.times do
    bike = FactoryBot.create(:bike, user: user)
    27.times do
      fuel = FactoryBot.create(:fuel, bike: bike)
    end
    15.times do
      fuel = FactoryBot.create(:repair, bike: bike)
    end
  end
end