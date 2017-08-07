require 'watir'

class Amazon
  extend Memoist

  PRODUCT_PAGE_ATTRIBUTES = %i[features images price rank reviews_count title].freeze
  CART_PAGE_ATTRIBUTES = %i[inventory].freeze

  def self.get_product(asin)
    new(asin).run
  end

  attr_accessor :asin, :features, :images, :price, :rank, :reviews_count, :title, :inventory

  def initialize(asin)
    @asin = asin
  end

  def run
    fetch_product_page_attributes!
    fetch_cart_page_attributes!
    attributes
  end

  def attributes
    (PRODUCT_PAGE_ATTRIBUTES + CART_PAGE_ATTRIBUTES).map do |attr|
      [attr, self[attr]]
    end.to_h
  end

  def fetch_product_page_attributes!
    browser.goto(url)
    PRODUCT_PAGE_ATTRIBUTES.each { |attr| self[attr] = get_attribute(attr) }
  end

  def fetch_cart_page_attributes!
    # todo
    # form = browser.form(id: 'addToCart').submit
    # browser.link(id: 'nav-cart').click
  end

  private

  def browser
    Watir::Browser.new
  end

  def get_attribute(attr)
    klass = "Amazon::#{ attr.to_s.camelize }".constantize
    klass.new(browser).value
  end

  def url
    Utils::Asin.url(asin)
  end

  memoize :browser
end
