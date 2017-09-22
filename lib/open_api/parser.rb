class OpenAPI
  #
  # Parses the original schema,
  # and converts it to the gem's internal representation
  # @private
  #
  module Parser
    module_function

    require_relative "parser/mapper"
    require_relative "parser/deref"
    require_relative "parser/share_servers"
    require_relative "parser/share_parameters"

    Error = Class.new(StandardError)
  end
end
