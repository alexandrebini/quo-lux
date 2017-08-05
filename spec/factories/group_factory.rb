FactoryGirl.define do
  factory :group do
    user
    product
    name { Faker::Internet.slug }
  end
end
