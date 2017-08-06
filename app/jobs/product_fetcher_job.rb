class ProductFetcherJob < ApplicationJob
  extend Memoist

  ATTRIBUTES = %i[features images inventory price rank reviews_count title].freeze
  attr_accessor :product_id

  def perform(product_id)
    @product_id = product_id
    return if product.blank? || product.fetching?
    product.fetching!
    fetch_product
  rescue StandardError => e
    on_error(e)
  ensure
    product.pending! if product.fetching?
  end

  def fetch_product
    return on_error('empty amazon response') if amazon_product.compact.blank?

    ATTRIBUTES.each do |attr|
      next if amazon_product[attr].blank?
      product.write_attribute(attr, amazon_product[attr])
    end

    on_success
  end

  private

  def product
    Product.find_by(id: product_id)
  end

  def amazon_product
    Amazon.get_product(product.url)
  end

  def on_error(error)
    product.update_attributes(
      status: next_status,
      last_fetch_status: :error,
      last_fetch_log: error,
      last_fetch_at: Time.now
    )
  end

  def on_success
    product.update_attributes(
      status: next_status,
      last_fetch_status: :success,
      last_fetch_log: nil,
      last_fetch_at: Time.now
    )
  end

  def next_status
    product.missing_attributes? ? :pending : :ready
  end

  memoize :product, :amazon_product
end
