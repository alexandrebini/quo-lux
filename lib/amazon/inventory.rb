class Amazon
  class Inventory < Base
    attr_accessor :cart_page
    MAX_VALUE = 999
    ALERT_QUANTITY_REGEXP = /only (\d+)/

    def value
      set_quantity!
      alert_quantity || MAX_VALUE
    end

    private

    def set_quantity!
      browser.select(name: 'quantity').select_value('10')
      browser.text_field(name: 'quantityBox').set(MAX_VALUE)
      browser.text_field(name: 'quantityBox').send_keys(:enter)
    end

    def quantity_alert_message
      alert = browser.element(css: '.sc-quantity-update-message .a-alert-content span')
      browser.wait_until(timeout: 2) { alert.exists? }
      alert.text if alert.exists?
    end

    def alert_quantity
      return if quantity_alert_message.blank?
      matcher = quantity_alert_message.match(ALERT_QUANTITY_REGEXP).to_a
      byebug
      digits = matcher.last.to_s.gsub(/[^\d]/, '')
      return if digits.blank?
      digits.to_i
    end
  end
end
