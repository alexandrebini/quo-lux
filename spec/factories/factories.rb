FactoryGirl.define do
  sequence :asin do |n|
    "#{Faker::Code.asin}#{n}"
  end

  sequence :email do |n|
    "user#{n}@gmail.com"
  end
end
