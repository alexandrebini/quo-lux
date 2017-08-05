FactoryGirl.define do
  factory :product do
    asin { generate(:asin) }
    sequence :title { Faker::Lorem.sentence }
  end
end
