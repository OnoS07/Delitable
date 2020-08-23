FactoryBot.define do
  factory :review do
    product_id {1}
    customer_id {1}
    rate {1}
    content{"test-content"}
  end
end