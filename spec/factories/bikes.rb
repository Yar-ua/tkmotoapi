FactoryBot.define do
  factory :bike do
    association :user, :factory => :user
    
    name { Faker::Name.name }
    volume { rand(50...2000) }
    year { rand(1970...2018) }
    color { Faker::Color.color_name }
  end
end
