FactoryBot.define do
  factory :class_communication do
    text { Faker::Lorem.sentence }
    title { Faker::Lorem.sentence }
    class_communication_day { Faker::Date.backward }
    association :user

    after(:build) do |message|
      message.images.attach(io: File.open('public/images/output-image1.png'), filename: 'test_image.png')
    end
  end
end
