FactoryBot.define do
  factory :bike_config do
    association :bike, :factory => :bike

    oil_change { Faker::Number.decimal(4, 1) }
  end
end
