FactoryBot.define do
  factory :item do
    name                { Faker::Commerce.product_name }
    introduce           { Faker::Lorem.sentence }
    grade_id            { Faker::Number.between(from: 1, to: 7) }
    size_id             { Faker::Number.between(from: 2, to: 32) }
    category_id         { Faker::Number.between(from: 2, to: 11) }
    status_id           { Faker::Number.between(from: 2, to: 7) }
    pay_for_shopping_id { Faker::Number.between(from: 2, to: 3) }
    delivery_area_id    { Faker::Number.between(from: 2, to: 48) }
    day_to_ship_id { Faker::Number.between(from: 2, to: 4) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/output-image1.png'), filename: 'test_image.png')
    end
  end
end
