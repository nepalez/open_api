module OpenAPI::Models
  #
  # Base class for models describing part of a schema
  # @abstract
  # @private
  #
  class Base
    extend Dry::Initializer

    class << self
      def new(*args)
        opts = args.pop
        if Hash === opts
          opts = opts.each_with_object({}) { |(k, v), obj| obj[k.to_sym] = v }
        end
        super(*args, opts)
      rescue StandardError => error
        raise Error.new(error.message, *args)
      end

      def call(*args)
        new(*args)
      end
    end

    def to_h
      @to_h ||= \
        self.class.dry_initializer.options
        .each_with_object { |item, obj| obj[item.source] = send(item.target) }
    end
  end
end
