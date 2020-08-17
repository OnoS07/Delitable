FactoryBot.define do
  factory :shipping do
    customer_id {1}
    name {"test-name"}
    postcode {1234567}
    address {"test-address"}

    association :customer
  end
end