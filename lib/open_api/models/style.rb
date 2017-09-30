module OpenAPI::Models
  #
  # Describes a serialization style for a parameter
  # @see https://swagger.io/specification/#parameter-locations-50
  # @private
  #
  class Style < String
    attr_reader :subject, :types

    def self.config
      @config ||= YAML.load_file("config/styles.yml")
    end

    def explode?
      @explode
    end

    def self.call(source, subject)
      new(source, subject)
    end

    private

    def initialize(source, subject)
      location = subject.location
      source ||= location.default_style

      unless location.styles.include?(source)
        raise Error, "inacceptable style '#{source}' of #{subject}"
      end

      super(source)
      @subject = subject
      config   = self.class.config[source]
      @types   = config["types"]
      @explode = config["explode"]
    end
  end
end
