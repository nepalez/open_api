class OpenAPI
  #
  # Parses the original schema,
  # and converts it to the gem's internal representation
  # @private
  #
  module Parser
    module_function

    require_relative "parser/handler"
    require_relative "parser/deref"

    Error = Class.new(StandardError)
  end
end
