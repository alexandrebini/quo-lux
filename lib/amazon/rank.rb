class Amazon
  class Rank < Base
    RANK_TEXT_REGEXP = /\#[^\s\}]*/

    def value
      digits = rank_text.to_s.gsub(/[^\d]/, '')
      return if digits.blank?
      digits.to_i
    end

    private

    def element
      browser.element(id: 'SalesRank')
    end

    def rank_text
      element.text.match(RANK_TEXT_REGEXP).to_a.first
    end

    memoize :element
  end
end
