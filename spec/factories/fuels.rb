FactoryBot.define do
  factory :fuel do
    association :bike, :factory => :bike

    distance { Faker::Number.decimal(3, 1) }
    odometer { Faker::Number.decimal(4, 1) }
    refueling { Faker::Number.decimal(2, 1) }
    price_fuel { Faker::Number.decimal(3, 1) }
  end
end
