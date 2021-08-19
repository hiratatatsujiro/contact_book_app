FactoryBot.define do
  factory :like do
    association :user
    association :class_communication
  end
end
