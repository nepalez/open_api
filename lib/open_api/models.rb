class OpenAPI
  #
  # Models wrap the OpenAPI schema to an enumerable collection of [Operations]
  # where every single [Operation] provides methods describing requirements
  # for different parts of request/responses.
  #
  # @private
  #
  module Models
    require_relative "models/error"
    require_relative "models/base"
    require_relative "models/boolean"
    require_relative "models/media_type"
    require_relative "models/media_types"
    require_relative "models/request_body"
    require_relative "models/location"
    require_relative "models/style"
    require_relative "models/parameter"
    require_relative "models/parameters"
    require_relative "models/headers"
    require_relative "models/status_code"
    require_relative "models/response"
    require_relative "models/operation"
    require_relative "models/operations"

    # @param  [Hash<String, Object>] schema Mapped schema to wrap
    # @return [OpenAPI::Models::Operations] enumerable collection of operations
    def self.[](schema)
      Operations.new(schema)
    end
  end
end
