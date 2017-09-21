module OpenAPI::Parser
  #
  # Provides interface for all handlers
  # @private
  #
  module Handler
    def self.extended(klass)
      klass.extend Dry::Initializer
    end

    def call(*args)
      new(*args).call
    end
  end
end
