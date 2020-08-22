FactoryBot.define do
  factory :cart_item do
    customer_id {1}
    product_id {1}
   	count {1}
   	association :customer
   	association :product
  end
end