class OpenAPI
  #
  # Parses the original schema and denornalizes all shared definitions
  # @private
  #
  module Mapper
    module_function

    require_relative "mapper/base"
    require_relative "mapper/deref"
    require_relative "mapper/share_parameters"
    require_relative "mapper/share_servers"

    Error   = Class.new(StandardError)
    Mappers = [Deref, ShareParameters, ShareServers].freeze

    def self.call(original)
      Mappers.inject(original) { |obj, mapper| mapper.call obj }
    end
  end
end
