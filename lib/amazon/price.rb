class Amazon
  class Price < Base
    def value
      return unless element.exists?
      digits = element.text.gsub(/[^\d]/, '')
      return if digits.blank?
      digits.to_i
    end

    private

    def element
      browser.element(id: 'priceblock_ourprice')
    end

    memoize :element
  end
end
