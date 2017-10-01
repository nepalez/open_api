module OpenAPI::Models
  #
  # Media Type object is a [#schema] for specifically [#format]ted [#parent]
  # @see https://swagger.io/specification/#media-type-object-58
  # @private
  #
  class MediaType < Base
    param  :parent
    param  :format
    option :schema, optional: true

    def to_s
      "#{parent} formatted as #{format}"
    end
    alias to_str  to_s
    alias inspect to_s
  end
end
