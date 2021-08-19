FactoryBot.define do
  factory :item_comment do
    comment { Faker::Lorem.sentence }
    association :user
    association :item
  end
end
