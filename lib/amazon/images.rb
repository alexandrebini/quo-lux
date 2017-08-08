class Amazon
  class Images < Base
    def value
      enable_images!
      images.select { |image| image =~ URI.regexp }
    end

    private

    def elements
      browser.elements(css: '.imgTagWrapper img').select(&:exists?)
    end

    def enable_images!
      thumbnails = browser.elements(css: '#altImages li.imageThumbnail img').select(&:exists?)
      return if thumbnails.blank?
      thumbnails.each(&:hover)
    end

    def images
      elements.map { |img| img.attribute_value('src') }
    end

    memoize :elements, :images
  end
end
