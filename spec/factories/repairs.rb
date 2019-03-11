FactoryBot.define do
  factory :repair do
    association :bike, :factory => :bike

    description { Faker::Hipster.paragraphs }
    detail { Faker::Hipster.sentences }
    price_detail { Faker::Number.decimal(3, 1) }
    
  end
end
