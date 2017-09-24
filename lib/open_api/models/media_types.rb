module OpenAPI::Models
  #
  # Enumerable collection of [MediaType]-s
  # @see https://swagger.io/specification/#media-type-object-58
  # @private
  #
  class MediaTypes < Base
    extend Enumerable

    attr_reader :subject

    def each
      return @data.values.to_enum unless block_given?
      @data.each_value { |item| yield(item) }
    end

    def [](format)
      @data.fetch format.to_s
    rescue StandardError
      raise Error, "Media type '#{format}' not specified for #{subject}"
    end

    def schema(value)
      self[value].schema
    end

    private

    def initialize(subject, data)
      @subject = subject
      @data = Hash(data).each_with_object({}) do |(type, item), obj|
        obj[type.to_s] = MediaType.new(subject, type, item)
      end
    end
  end
end
