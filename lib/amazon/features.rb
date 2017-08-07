class Amazon
  class Features < Base
    def value
      elements.map { |r| r.text.strip }.reject(&:blank?).compact.uniq
    end

    private

    def elements
      byebug
      browser.elements(css: '#feature-bullets li span')
    end

    memoize :elements
  end
end
