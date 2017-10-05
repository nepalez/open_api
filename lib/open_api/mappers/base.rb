module OpenAPI::Mappers
  #
  # Provides interface for all data mappers that process an original schema
  # @private
  #
  class Base
    extend Dry::Initializer

    def self.call(*args)
      new(*args).call
    end
  end
end
