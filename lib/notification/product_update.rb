module Notification
  class ProductUpdate
    extend Memoist
    NOTIFICABLE_ATTRIBUTES = Product::NOTIFICABLE_ATTRIBUTES

    attr_accessor :product_id

    def initialize(product_id)
      @product_id = product_id
    end

    def changes
      return if product.blank?
      last_version.changeset.select { |key, _value| NOTIFICABLE_ATTRIBUTES.include?(key.to_sym) }
    end

    def nil?
      changes.blank?
    end

    def product
      Product.find_by(id: product_id)
    end

    def last_version
      product.versions.last
    end

    private

    def cache_key
      "notification/product_update/#{last_version.id}"
    end

    memoize :product, :cache_key
  end
end
