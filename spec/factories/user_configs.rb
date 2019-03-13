FactoryBot.define do
  factory :user_config do
    association :user, :factory => :user
    
    language { Faker::ProgrammingLanguage.name }
  end
end
