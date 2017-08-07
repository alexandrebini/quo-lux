module Amazon
  class Inventory < Base
    attr_accessor :cart_page

    def value
      # TODO
    end

    def add_to_cart!
    end

    private

    def add_to_chart_form
      page.form_with(id: 'addToCart')
    end
  end
end
