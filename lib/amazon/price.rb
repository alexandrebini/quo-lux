module Amazon
  class Price < Base
    # assuming just the first price in range for now
    def value
      parse_price(price_range.first)
    end

    private

    def element
      page.search('#priceblock_ourprice')
    end

    def price_range
      element.text.split('-')
    end

    def parse_price(price)
      digits = price.to_s.gsub(/[^\d]/, '')
      return if digits.blank?
      digits.to_i
    end
  end
end
