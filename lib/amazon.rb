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
    fetch_product_page_attributes
    fetch_cart_page_attributes
    attributes
  ensure
    browser.try(:close)
  end

  def attributes
    attribute_names = PRODUCT_PAGE_ATTRIBUTES + CART_PAGE_ATTRIBUTES
    attribute_names.map { |attr| [attr, send(attr)] }.to_h
  end

  def fetch_product_page_attributes
    url = Utils::Asin.url(asin)
    browser.goto_product_page(url, select_default: true)
    PRODUCT_PAGE_ATTRIBUTES.each { |attr| get_attribute(attr) }
  end

  def fetch_cart_page_attributes
    if browser.goto_cart_page
      CART_PAGE_ATTRIBUTES.each { |attr| get_attribute(attr) }
    else
      self.inventory = 0
    end
  end

  private

  def browser
    Amazon::Browser.new
  end

  def get_attribute(attr)
    klass = "Amazon::#{ attr.to_s.camelize }".constantize
    value = klass.new(browser).value
    send("#{attr}=", value)
  end

  memoize :browser
end
