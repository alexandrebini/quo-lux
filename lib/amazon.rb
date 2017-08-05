module Amazon
  AVAILABLE_ATTRIBUTES = %i[
    asin
    features
    images
    inventory
    price
    rank
    reviews_count
    title
  ].freeze

  class << self
    def get_product(url)
      agent = Mechanize.new
      page = agent.get(url)
      attrs = AVAILABLE_ATTRIBUTES.map { |attr| [attr, get_attribute(page, attr)] }
      Hash[attrs]
    end

    def get_attribute(page, attribute)
      klass = "Amazon::#{ attribute.to_s.camelize }".constantize
      klass.new(page).value
    end
  end
end
