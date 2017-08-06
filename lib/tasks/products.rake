namespace :products do
  desc 'Run fetcher for all products'
  task fetch: :environment do
    Product.find_each { |product| ProductFetcherJob.perform_later(product.id) }
  end
end
