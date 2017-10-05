module OpenAPI::Models
  #
  # [Operation] response definition for some status
  # @private
  #
  class Response < Base
    param  :parent
    param  :status,  StatusCode
    option :headers, Headers,    optional: true
    option :content, MediaTypes, optional: true

    def order
      status.order
    end

    def match(code)
      status.match(code)
    end
  end
end
