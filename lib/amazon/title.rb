module Amazon
  class Title < Base
    def value
      page.search('#productTitle').text.strip
    end
  end
end
