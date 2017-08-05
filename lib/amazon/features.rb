module Amazon
  class Features < Base
    def value
      element.map { |r| r.text.strip }.compact.uniq
    end

    private

    def element
      page.search('#feature-bullets li span')
    end
  end
end
