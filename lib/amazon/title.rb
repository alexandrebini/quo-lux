class Amazon
  class Title < Base
    def value
      element.text.strip
    end

    private

    def element
      browser.element(id: 'productTitle')
    end

    memoize :element
  end
end
