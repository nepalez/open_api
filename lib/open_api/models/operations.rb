module OpenAPI::Models
  #
  # Enumerable collection of named [Operation]-s
  # @private
  #
  class Operations
    include Enumerable

    def each
      block_given? ? @list.each { |item| yield(item) } : @list.to_enum
    end

    def [](id)
      find { |operation| operation.id == id.to_s }
    end

    private

    def initialize(data)
      @list = data["paths"].to_h.flat_map do |path, paths|
        paths.to_h.map { |verb, _| Operation.new(data, path, verb) }
      end
    end
  end
end
