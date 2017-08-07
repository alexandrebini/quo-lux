class Amazon
  class ReviewsCount < Base
    def value
      return if element.blank?
      digits = element.text.to_s.gsub(/[^\d]/, '')
      return if digits.blank?
      digits.to_i
    end

    private

    def element
      element = browser.element(css: '.totalReviewCount')
      return unless element.exists?
      element
    end

    memoize :element
  end
end
