FactoryBot.define do
  factory :diary do
    diary                 { Faker::Lorem.sentence }
    title                 { Faker::Lorem.sentence }
    diary_day             { Faker::Date.backward }
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/output-image1.png'), filename: 'test_image.png')
    end
  end
end
