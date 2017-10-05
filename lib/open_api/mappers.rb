class OpenAPI
  #
  # Reads the original schema and converts it to denormalized form
  # where every operation (path + verb) collects all its definitions.
  #
  # @private
  #
  module Mappers
    module_function

    require_relative "mappers/base"
    require_relative "mappers/deref"
    require_relative "mappers/share_parameters"
    require_relative "mappers/share_security"
    require_relative "mappers/share_servers"

    Error = Class.new(StandardError)
    List  = [Deref, ShareParameters, ShareSecurity, ShareServers].freeze

    # @param  [Hash<String, Object>] original The original schema to map
    # @return [Hash<String, Object>] mapped schema
    def self.[](original)
      List.inject(original) { |obj, mapper| mapper.call obj }
    end
  end
end
