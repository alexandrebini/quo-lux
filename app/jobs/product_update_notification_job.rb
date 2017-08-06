class ProductUpdateNotificationJob < ApplicationJob
  extend Memoist

  attr_accessor :product_id

  def perform(product_id)
    @product_id = product_id
    return if product.blank?

    product.users.find_each do |user|
      NotificationMailer.product_update(product_id, user.id).deliver_later
    end
  end

  private

  def product
    Product.find_by(id: product_id)
  end

  memoize :product
end
