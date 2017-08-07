class Amazon
  class Base
    extend Memoist
    attr_reader :browser

    def initialize(browser)
      @browser = browser
    end

    def value
      raise 'method :value not implemented'
    end
  end
end
