module OpenAPI::Models
  #
  # Enumerable collection of [Response]-s of some [Operation]
  # @private
  #
  class Responses
    include Enumerable

    attr_reader :parent

    def each
      block_given? ? @list.each { |item| yield(item) } : @list.to_enum
    end

    def [](status)
      sort_by(&:order).find { |response| response.match(status) }
    end

    def select
      self.class.new(super, parent)
    end

    def reject
      self.class.new(super, parent)
    end

    def self.call(data, parent)
      new data, parent
    end

    private

    def initialize(data, parent)
      @parent = parent
      @list = \
        case data
        when self.class, Array then data.to_a
        else
          data.map do |status, item|
            Response === item ? item : Response.new(parent, status, item)
          end
        end
    end
  end
end
