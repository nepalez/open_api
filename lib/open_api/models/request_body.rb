module OpenAPI::Models
  #
  # @see https://swagger.io/specification/#request-body-object-55
  # @private
  #
  class RequestBody < Base
    param  :parent
    option :content,  MediaTypes
    option :required, Boolean, default: -> { false }

    def to_s
      "request body of #{parent}"
    end
    alias to_str  to_s
    alias inspect to_s

    def schema(format)
      content.schema(format)
    end

    def self.call(data, parent)
      new(parent, data)
    end
  end
end
