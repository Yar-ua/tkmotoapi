FactoryBot.define do
  factory :repair do
    association :bike, :factory => :bike

    description { (Faker::Markdown.unordered_list)*7 }
    detail { Faker::Markdown.inline_code }
    price_detail { Faker::Number.decimal(3, 1) }
    
  end
end
