class Amazon
  class Price < Base
    def value
      digits = element.text.gsub(/[^\d]/, '')
      return if digits.blank?
      digits.to_i
    end

    private

    def element
      element = browser.element(id: 'priceblock_ourprice')
      return unless element.exists?
      element
    end

    memoize :element
  end
end
