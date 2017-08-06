module Concerns
  module ProductFinder
    extend ActiveSupport::Concern

    included do
      # before_validation :set_product, prepend: true
      # attr_writer :product_finder
    end

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

    # private

    # def set_product
    #   p '----------set_product', self, product_finder
    #   asin = Utils::Asin.from_url(product_finder)
    #   if asin.blank?
    #     self.product = nil
    #     self.mark_for_destruction
    #   else
    #     self.product = Product.where(asin: asin).first_or_create
    #   end
    # end
  end
end
