FactoryBot.define do
  factory :order do
    name {"test-name"}
    postcode {1234567}
    address {"test-address"}
    postage {800}
    total_products_cost {1000}
  end
end