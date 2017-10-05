module OpenAPI::Models
  #
  # Enumerable collection of named [Parameter]-s of some [Operation]
  # @private
  #
  class Parameters
    include Enumerable

    attr_reader :parent

    def each
      block_given? ? @list.each { |item| yield(item) } : @list.to_enum
    end

    def self.call(data, parent)
      new(data, parent)
    end

    private

    def initialize(data, parent)
      @parent = parent
      @list = data.map do |item|
        Parameter === item ? item : Parameter.new(parent, item)
      end
    end
  end
end
