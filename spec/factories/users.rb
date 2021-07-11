FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password = 'a1' + Faker::Internet.password(min_length: 6, mix_case: false)
    password              { password }
    password_confirmation { password }
    introduction          { Faker::Lorem.sentence }
    birthday              { Faker::Date.backward }
    grade_id              { Faker::Number.between(from: 2, to: 7) }
    classroom_id          { Faker::Number.between(from: 2, to: 31) }
    number_id             { Faker::Number.between(from: 2, to: 51) }
    transient do
      person { Gimei.name }
    end
    last_name             { person.last.kanji }
    first_name            { person.first.kanji }
    last_name_reading     { person.last.katakana }
    first_name_reading    { person.first.katakana }
  end
end

