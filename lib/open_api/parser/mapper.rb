module OpenAPI::Parser
  #
  # Provides interface for all data mappers that process an original schema
  # @private
  #
  class Mapper
    extend Dry::Initializer

    def self.call(*args)
      new(*args).call
    end
  end
end
