FactoryBot.define do
  factory :contact do
<<<<<<< Updated upstream
    
=======
    condition_id      { Faker::Number.between(from: 1, to: 5) }
    reason            { Faker::Lorem.sentence }
    pool_marathon_id  { Faker::Number.between(from: 1, to: 4) }
    contact           { Faker::Lorem.sentence }
    association :user
>>>>>>> Stashed changes
  end
end
