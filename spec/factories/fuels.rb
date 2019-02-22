FactoryBot.define do
  factory :fuel do
    association :bike, :factory => :bike

    distance { rand(1...1000) }
    odometer { distance + 1000 }    
    refueling { rand(1...40) }
    price_fuel { rand(1...2000) }
  end
end
