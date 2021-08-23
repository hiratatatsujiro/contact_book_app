FactoryBot.define do
  factory :timetable do
<<<<<<< Updated upstream
    
=======
    next_day         { Faker::Date.backward }
    first_class_id   { Faker::Number.between(from: 2, to: 13) }
    second_class_id  { Faker::Number.between(from: 2, to: 13) }
    third_class_id   { Faker::Number.between(from: 2, to: 13) }
    fourth_class_id  { Faker::Number.between(from: 2, to: 13) }
    fifth_class_id   { Faker::Number.between(from: 2, to: 13) }
    sixth_class_id   { Faker::Number.between(from: 2, to: 13) }
    homework         { Faker::Lorem.sentence }
    preparation      { Faker::Lorem.sentence }
    leave_time       { Faker::Lorem.sentence }
    notice           { Faker::Lorem.sentence }
    association :user
>>>>>>> Stashed changes
  end
end
