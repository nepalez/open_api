module OpenAPI::Models
  #
  # Describes one a request locations (path, query etc.) for a [Parameter]
  # @see https://swagger.io/specification/#parameter-locations-50
  # @private
  #
  class Location < String
    attr_reader :subject

    def query?
      self == "query"
    end

    def header?
      self == "header"
    end

    def cookie?
      self == "cookie"
    end

    def path?
      self == "path"
    end

    # @see https://swagger.io/specification/#parameterIn
    alias required? path?

    # @see https://swagger.io/specification/#securitySchemeIn
    def security?
      !path?
    end

    private

    LIST = %w[query path header cookie]

    def initialize(subject, source)
      unless LIST.include? source
        raise Error, "invalid location '#{source}' for #{subject}"
      end

      super(source)
      @subject = subject
    end
  end
end
