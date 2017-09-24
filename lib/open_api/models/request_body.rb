module OpenAPI::Models
  #
  # @see https://swagger.io/specification/#request-body-object-55
  # @private
  #
  class RequestBody < Base
    param  :subject # described by the media type
    option :content,  ->(v, body) { MediaTypes.new(body, v) }
    option :required, ->(v) { v.to_s == "true" }, default: -> { false }

    def to_s
      "request body of #{subject}"
    end
    alias to_str  to_s
    alias inspect to_s

    def schema(format)
      content.schema(format)
    end
  end
end
