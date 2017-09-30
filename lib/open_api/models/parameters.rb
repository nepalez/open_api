module OpenAPI::Models
  #
  # Enumerable collection of named [Parameter]-s of some [Operation]
  # @private
  #
  class Parameters
    require_relative "parameter"

    include Enumerable

    attr_reader :operation

    def each
      block_given? ? @list.each { |item| yield(item) } : @list.to_enum
    end

    def self.call(data, operation)
      new(data, operation)
    end

    private

    def initialize(data, operation)
      @operation = operation
      @list = data.map do |item|
        Parameter === item ? item : Parameter.new(operation, item)
      end
    end
  end
end
