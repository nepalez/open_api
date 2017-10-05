module OpenAPI::Mappers
  #
  # Shares server definitions to operations
  # Removes servers from both the root, and path items
  # @private
  #
  class ShareServers < Base
    param :source, method(:Hash)

    def call
      source.merge("paths" => new_paths).reject { |key| key == "servers" }
    end

    private

    VERBS = %w[get post put patch delete options head trace].freeze

    def initialize(source)
      super
      @paths   = Hash source["paths"]
      @servers = source["servers"].to_a
    end

    def new_paths
      @paths.each_with_object({}) do |(path, path_data), obj|
        path_data = Hash(path_data)
        default   = { "servers" => path_data.fetch("servers", @servers) }
        obj[path] = path_data.each_with_object({}) do |(verb, data), o|
          o[verb] = new_data(verb, data, default) unless verb == "servers"
        end
      end
    end

    def new_data(verb, original, default)
      VERBS.include?(verb) ? default.merge(original) : original
    end
  end
end
