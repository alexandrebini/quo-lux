module Concerns
  module ProductFinder
    extend ActiveSupport::Concern

    def product_finder
      return product.try(:asin) if @product_finder.blank?
      @product_finder
    end

    def product_finder=(value)
      @product_finder = value
      asin = Utils::Asin.from_url(@product_finder)
      return self.product = nil if asin.blank?
      self.product = Product.where(asin: asin).first_or_create
    end
  end
end
