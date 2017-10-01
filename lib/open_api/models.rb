class OpenAPI
  #
  # Namespace for models describing different parts of a schema
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
    require_relative "models/operation"
    require_relative "models/operations"
  end
end
