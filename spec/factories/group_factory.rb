FactoryGirl.define do
  factory :group do
    user
    name { Faker::Internet.slug }
  end
end
