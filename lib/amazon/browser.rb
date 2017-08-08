class Amazon
  class Browser
    extend Memoist
    delegate :close, :element, :elements, :select, :text_field, to: :browser

    def browser
      Watir::Browser.new(:chrome, driver_options)
    end

    def goto_product_page(url, select_default: false)
      browser.goto(url)
      select_default_size if select_default
    end

    def goto_cart_page
      add_to_chart = browser.form(id: 'addToCart')
      wait_until(timeout: 30) { add_to_chart.exists? }
      return false if browser.element(id: 'outOfStock').exists?

      add_to_chart.submit
      wait_until(timeout: 30) { !add_to_chart.exists? }
      browser.goto('https://www.amazon.com/gp/cart/view.html')
      true
    end

    def wait_until(*args, &block)
      browser.wait_until(*args, &block)
    rescue Watir::Wait::TimeoutError
      return nil
    end

    private

    def select_default_size
      size_select = browser.select(id: 'native_dropdown_selected_size_name')
      return if !size_select.exists? || size_select.value != '-1'
      main_option = size_select.options.find { |option| option.attribute_value('value') != '-1' }
      main_option.click
    end

    def driver_options
      return {} unless Rails.env.production?
      { chromeOptions: { binary: '/app/.apt/usr/bin/google-chrome' } }
    end

    memoize :browser
  end
end
