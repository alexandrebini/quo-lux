class Amazon
  class Title < Base
    def value
      return if element.blank?
      element.text.strip
    end

    private

    def element
      element = browser.element(id: 'productTitle')
      return unless element.exists?
      element
    end

    memoize :element
  end
end
