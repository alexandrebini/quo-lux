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
    goto_product_page
    PRODUCT_PAGE_ATTRIBUTES.each { |attr| get_attribute(attr) }
  end

  def fetch_cart_page_attributes
    if goto_cart_page
      CART_PAGE_ATTRIBUTES.each { |attr| get_attribute(attr) }
    else
      self.inventory = 0
    end
  end

  private

  def browser
    Watir::Browser.new(:phantomjs)
  end

  def get_attribute(attr)
    klass = "Amazon::#{ attr.to_s.camelize }".constantize
    value = klass.new(browser).value
    send("#{attr}=", value)
  end

  def url
    Utils::Asin.url(asin)
  end

  def goto_product_page
    browser.goto(url)
    size_select = browser.select(id: 'native_dropdown_selected_size_name')
    return if !size_select.exists? || size_select.value != '-1'
    main_option = size_select.options.find { |option| option.attribute_value('value') != '-1' }
    main_option.click
  end

  def goto_cart_page
    return false if browser.element(id: 'outOfStock').exists?
    browser.form(id: 'addToCart').submit
    browser.link(id: 'nav-cart').click
    true
  end

  memoize :browser, :url
end
