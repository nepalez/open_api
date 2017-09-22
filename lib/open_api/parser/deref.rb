module OpenAPI::Parser
  #
  # Populates the scheme with content of their '$ref' keys.
  # Removes all referred data from components. Leaves only securitySchemes,
  # that are referred via security requirements.
  # @private
  #
  class Deref < Base
    param :source, method(:Hash)

    def call
      convert(source).tap { |data| data["components"] = components }
    end

    private

    def convert(data)
      return data.map { |item| convert(item) } if data.is_a?(Array)
      return data unless data.is_a?(Hash)
      return resolve data["$ref"] if data.key? "$ref"
      data.each_with_object({}) { |(key, val), obj| obj[key] = convert(val) }
    end

    def resolve(ref)
      raise Error, "External refs not supported: #{ref}" unless ref[%r{^\#/}]
      keys = ref.sub("#/", "").split("/")
      convert source.dig(*keys)
    end

    def components
      source["components"].select { |key| key == "securitySchemes" }
    end
  end
end
