module Amazon
  class Base
    attr_reader :page

    def initialize(page)
      @page = page
    end

    def value
      raise 'method :value not implemented'
    end
  end
end
