FactoryBot.define do
  factory :cooking do
    recipe_id {1}
    content {"test-content"}
    association :recipe
  end
end