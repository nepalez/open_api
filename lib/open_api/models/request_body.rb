module OpenAPI::Models
  #
  # @see https://swagger.io/specification/#request-body-object-55
  # @private
  #
  class RequestBody < Base
    BOOLEAN = ->(v) { v.to_s == "true" }

    param  :subject # described by the media type
    option :content,  MediaTypes
    option :required, BOOLEAN, default: -> { false }

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
