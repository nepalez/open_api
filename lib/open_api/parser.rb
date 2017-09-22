class OpenAPI
  #
  # Parses the original schema and denornalizes all shared definitions
  # @private
  #
  module Parser
    module_function

    require_relative "parser/base"
    require_relative "parser/deref"
    require_relative "parser/share_parameters"
    require_relative "parser/share_servers"

    Error   = Class.new(StandardError)
    Mappers = [Deref, ShareParameters, ShareServers].freeze

    def self.call(original)
      Mappers.inject(original) { |obj, mapper| mapper.call obj }
    end
  end
end
