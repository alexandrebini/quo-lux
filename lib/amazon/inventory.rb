class Amazon
  class Inventory < Base
    attr_accessor :cart_page

    def value
      # TODO
    end

    def add_to_cart!
      browser.text_field(name: 'quantityBox').set(999)
      browser.text_field(name: 'quantityBox').send_keys(:enter)
    end

    private

    def add_to_chart_form
      browser.form_with(id: 'addToCart')
    end
  end
end
