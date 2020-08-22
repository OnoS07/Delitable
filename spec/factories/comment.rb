FactoryBot.define do
  factory :comment do
    customer_id {1}
    recipe_id {1}
    content {"test_comment"}
    association :customer
    association :recipe
  end
end