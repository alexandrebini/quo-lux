FactoryGirl.define do
  factory :product do
    asin { generate(:asin) }
    title { Faker::Lorem.sentence }
    features { [Faker::Lorem.sentences(3)] }
    images { [Faker::Internet.url, Faker::Internet.url] }
    inventory { Faker::Number.between(1, 9_999) }
    price { Faker::Number.between(1_000, 99_999) }
    rank { Faker::Number.between(1, 9_999) }
    reviews_count { Faker::Number.between(1, 50) }

    after(:build) do |product|
      product.class.skip_callback(:commit, :after, :enqueue_fetcher, raise: false)
      product.class.skip_callback(:commit, :after, :enqueue_notification, raise: false)
    end
  end
end
