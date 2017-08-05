module Amazon
  class Asin < Base
    def value
      element.attr(:value).strip
    end

    private

    def element
      page.search('#ASIN').first
    end
  end
end
