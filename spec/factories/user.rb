FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.unique.password }
    name { Faker::Name.unique.first_name }
  end

end