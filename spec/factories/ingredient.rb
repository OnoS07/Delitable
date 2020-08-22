FactoryBot.define do
  factory :ingredient do
    recipe_id {1}
    content {"test-content"}
    amount {"test"}
    association :recipe
  end
end