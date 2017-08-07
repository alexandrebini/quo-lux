class Amazon
  class ReviewsCount < Base
    def value
      digits = element.text.to_s.gsub(/[^\d]/, '')
      return if digits.blank?
      digits.to_i
    end

    private

    def element
      browser.element(css: '.totalReviewCount')
    end
  end
end
