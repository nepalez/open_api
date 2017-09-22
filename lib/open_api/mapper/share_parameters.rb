module OpenAPI::Mapper
  #
  # Moves parameters from path items to operations
  # @private
  #
  class ShareParameters < Base
    param :source, method(:Hash)

    def call
      source.merge("paths" => new_paths)
    end

    private

    VERBS = %w[get post put patch delete options head trace].freeze

    def initialize(source)
      super
      @paths = Hash source["paths"]
    end

    def new_paths
      @paths.each_with_object({}) do |(path, path_data), obj|
        path_data = Hash path_data
        default   = path_data["parameters"].to_a
        obj[path] = path_data.each_with_object({}) do |(verb, data), o|
          o[verb] = new_data(verb, data, default) unless verb == "parameters"
        end
      end
    end

    def new_data(verb, original, default)
      return original unless VERBS.include? verb

      parameters = default + original["parameters"].to_a
      return original if parameters.empty?

      original.merge "parameters" => parameters
    end
  end
end
