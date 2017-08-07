class Amazon
  class Images < Base
    def value
      images.select { |image| image =~ URI.regexp }
    end

    private

    def elements
      thumbs = browser.elements(css: '#altImages li.imageThumbnail img')
      thumbs.each(&:hover)
      browser.elements(css: '.imgTagWrapper img')
    end

    def images
      elements.map { |img| img.attribute_value('src') }
    end
  end
end
