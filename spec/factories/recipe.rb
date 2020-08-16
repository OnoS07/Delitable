FactoryBot.define do
  factory :recipe do
    customer_id {1}
    title {"test-title"}
    introduction {"test-introduction"}
    amount {"test"}
    association :customer
  end
end