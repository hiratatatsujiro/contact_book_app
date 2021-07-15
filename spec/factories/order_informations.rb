FactoryBot.define do
  factory :order_information do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '111-1111' }
    delivery_area_id { Faker::Number.between(from: 2, to: 48) }
    city { Faker::Address.city }
    house_number { Faker::Address.street_address }
    building { '建物' }
    phone_number { "0#{rand(0..9)}0#{rand(1_000_000..99_999_999)}" }
  end
end
