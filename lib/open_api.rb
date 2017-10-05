require "dry-initializer"
require "json-schema"
require "yaml"
require "uri"

# Specification-based API
class OpenAPI
  require_relative "open_api/loaders"
  require_relative "open_api/mappers"
  require_relative "open_api/models"

  extend Loaders # constructors: load_yml

  # @!attribute [r] schema
  # @return [Hash] the original Open API schema
  attr_reader :schema

  private

  def initialize(schema)
    @schema     = schema
    @operations = Models[Mappers[schema]]
  end
end
