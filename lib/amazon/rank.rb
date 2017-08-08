class Amazon
  class Rank < Base
    RANK_TEXT_REGEXP = /Best Sellers Rank.+\#[^\s\}]*/

    def value
      digits = rank_text.to_s.gsub(/[^\d]/, '')
      return if digits.blank?
      digits.to_i
    end

    private

    def element
      elements = [
        browser.element(id: 'SalesRank'),
        browser.element(id: 'productDetails_detailBullets_sections1')
      ]
      elements.find(&:exists?)
    end

    def rank_text
      return if element.blank?
      element.text.match(RANK_TEXT_REGEXP).to_a.first
    end

    memoize :element
  end
end
