class Amazon
  class Images < Base
    def value
      images.select { |image| image =~ URI.regexp }
    end

    private

    def elements
      browser.elements(css: '#altImages li.imageThumbnail img')
    end

    def images
      elements.each do |img|
        img.hover
        current_image_url
      end.flatten.compact.uniq
    end

    def current_image_url
      browser.element(css: '.imgTagWrapper img').attribute_value('src')
    end
  end
end
