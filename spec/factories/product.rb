FactoryBot.define do
  factory :product do
    genre_id {1}
    name {"test-name"}
    price {100}
    introduction {"test-introduction"}
    association :genre
  end
end