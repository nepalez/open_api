require "dry-initializer"
require "json"
require "json-schema"
require "yaml"
require "uri"

# Specification-based API
class OpenAPI
  require_relative "open_api/loaders"
  require_relative "open_api/parser"

  extend Loaders

  # @!attribute [r] schema
  # @return [Hash] the original Open API schema
  attr_reader :schema

  private

  def initialize(schema)
    @schema = schema
  end
end
