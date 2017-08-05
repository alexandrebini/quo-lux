module Amazon
  class Images < Base
    # using only hight resolution images for now
    RANK_TEXT_REGEXP = /\"hiRes\"\:\"([^\,\}]*)\"/

    def value
      images.select { |image| image =~ URI.regexp }
    end

    private

    def element
      page.search('script')
    end

    def images
      element.text.scan(RANK_TEXT_REGEXP).flatten.compact.uniq
    end
  end
end
