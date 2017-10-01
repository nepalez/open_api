module OpenAPI::Models
  #
  # Describes a serialization style for a parameter
  # @see https://swagger.io/specification/#parameter-locations-50
  # @private
  #
  class Style < String
    attr_reader :parent, :types

    def self.config
      @config ||= YAML.load_file("config/styles.yml")
    end

    def explode?
      @explode
    end

    def self.call(source, parent)
      new(source, parent)
    end

    private

    def initialize(source, parent)
      location = parent.location
      source ||= location.default_style

      unless location.styles.include?(source)
        raise Error, "inacceptable style '#{source}' of #{parent}"
      end

      super(source)
      @parent = parent
      config   = self.class.config[source]
      @types   = config["types"]
      @explode = config["explode"]
    end
  end
end
