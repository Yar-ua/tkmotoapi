FactoryBot.define do
  factory :oil do
    association :bike, :factory => :bike

    oil_distance { Faker::Number.decimal(3) }
  end
end
