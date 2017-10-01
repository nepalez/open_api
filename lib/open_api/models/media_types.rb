module OpenAPI::Models
  #
  # Enumerable collection of [MediaType]-s
  # @see https://swagger.io/specification/#media-type-object-58
  # @private
  #
  class MediaTypes < Base
    extend Enumerable

    attr_reader :parent

    def each
      return @data.values.to_enum unless block_given?
      @data.each_value { |item| yield(item) }
    end

    def [](format)
      @data.fetch format.to_s
    rescue StandardError
      raise Error, "Media type '#{format}' not specified for #{parent}"
    end

    def schema(value)
      self[value].schema
    end

    def self.call(source, parent)
      new(source, parent)
    end

    private

    def initialize(source, parent)
      @parent = parent
      @data = Hash(source).each_with_object({}) do |(type, item), obj|
        obj[type.to_s] = MediaType.new(parent, type, item)
      end
    end
  end
end
