module Utils
  module Asin
    ASIN_REGEXP = %r[\/dp\/([a-zA-Z0-9]{10})/i]

    class << self
      def from_url(url)
        return if url.blank?
        url.match(ASIN_REGEXP).try(:captures).try(:first) || url
      end

      def url(asin)
        "http://www.amazon.com/dp/#{asin}"
      end
    end
  end
end
