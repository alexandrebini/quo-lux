class Amazon
  class Images < Base
    def value
      enable_images!
      images.select { |image| image =~ URI.regexp }
    end

    private

    def elements
      browser.elements(css: '.imgTagWrapper img')
    end

    def enable_images!
      browser.elements(css: '#altImages li.imageThumbnail img').each(&:hover)
    end

    def images
      elements.map { |img| img.attribute_value('src') }
    end

    memoize :elements, :images
  end
end
