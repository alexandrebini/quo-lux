class Amazon
  class Price < Base
    def value
      return if price_text.blank?
      digits = price_text.gsub(/[^\d]/, '')
      return if digits.blank?
      digits.to_i
    end

    private

    def element
      elements = [
        browser.element(id: 'priceblock_ourprice'),
        browser.element(id: 'priceblock_saleprice')
      ]
      elements.find(&:exists?)
    end

    def price_text
      return if element.blank?
      element.text.to_s.split('-').first
    end

    memoize :element
  end
end
