module OpenAPI::Models
  #
  # Describes a serialization style for a parameter
  # @see https://swagger.io/specification/#parameter-locations-50
  # @private
  #
  class Style < String
    attr_reader :subject

    def query?
      LIST[self].include? "query"
    end

    def path?
      LIST[self].include? "path"
    end

    def cookie?
      LIST[self].include? "cookie"
    end

    def header?
      LIST[self].include? "header"
    end

    def defined?
      self != "n/a"
    end

    private

    LIST = {
      "matrix"         => %w[path],
      "label"          => %w[path],
      "form"           => %w[query cookie],
      "simple"         => %w[path header],
      "spaceDelimited" => %w[query],
      "pipeDelimited"  => %w[query],
      "deepObject"     => %w[query],
      "n/a"            => %w[path query cookie header]
    }.freeze

    def initialize(subject, source)
      source ||= "n/a"

      unless LIST.keys.include? source
        raise Error, "invalid style '#{source}' of #{subject}"
      end

      super(source)
      @subject = subject
    end
  end
end
