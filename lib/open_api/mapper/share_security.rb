module OpenAPI::Mapper
  #
  # Moves parameters from path items to operations
  # @private
  #
  class ShareSecurity < Base
    param :source, method(:Hash)

    def call
      source.merge("paths" => new_paths).reject { |key| key == "security" }
    end

    private

    VERBS = %w[get post put patch delete options head trace].freeze

    def initialize(source)
      super
      @security = source["security"].to_a
      @paths    = Hash source["paths"]
    end

    def new_paths
      @paths.each_with_object({}) do |(path, path_data), obj|
        path_data = Hash path_data
        obj[path] = path_data.each_with_object({}) do |(verb, data), o|
          o[verb] = new_data(verb, data)
        end
      end
    end

    def new_data(verb, original)
      return original unless VERBS.include? verb

      security = original["security"].to_a
      security = @security if security.empty?
      return original if security.empty?

      original.merge("security" => security)
    end
  end
end
