FactoryBot.define do
  factory :shipping do
    name { 'test-name' }
    postcode { 1_234_567 }
    address { 'test-address' }
  end
end
