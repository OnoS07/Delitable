FactoryBot.define do
  factory :order_detail do
    product_id {1}
    order_id {1}
    count {1}
    price {200}

    association :order
    association :product
  end
end