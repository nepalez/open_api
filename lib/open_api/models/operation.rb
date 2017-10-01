module OpenAPI::Models
  # @private
  class Operation < Base
    param :schema
    param :path
    param :verb
    # extracted from [#schema] for a further usage
    option :operationId, proc(&:to_s), as: :id
    option :deprecated,  Boolean,      default: -> { false }
    option :parameters,  Parameters,   default: -> { Parameters.new([], self) }
    option :requestBody, RequestBody,  optional: true, as: :body

    def self.new(schema, path, verb)
      data = schema.dig("paths", path, verb)
      raise Error, "undefined operation '#{verb.upcase} #{path}'" unless data
      super(schema, path, verb, data)
    end
  end
end
