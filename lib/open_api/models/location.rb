module OpenAPI::Models
  #
  # Describes one a request locations (path, query etc.) for a [Parameter]
  # @see https://swagger.io/specification/#parameter-locations-50
  # @private
  #
  class Location < String
    attr_reader :parent

    def self.config
      @config ||= YAML.load_file "config/locations.yml"
    end

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
    def required?
      @config["required"]
    end

    # @see https://swagger.io/specification/#securitySchemeIn
    def security?
      @config["security"]
    end

    def styles
      @config["styles"]
    end

    def default_style
      @config["default"]
    end

    def self.call(source, parent)
      new(source, parent)
    end

    private

    def initialize(source, parent)
      @parent = parent
      @config ||= self.class.config.fetch(source.to_s) do
        raise Error, "invalid location '#{source}' for #{parent}"
      end
      super(source)
    end
  end
end
