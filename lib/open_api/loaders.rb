class OpenAPI
  #
  # Methods to load schema from various sources
  #
  module Loaders
    #
    # Loads schema from a YAML file
    #
    # @param  [String] filename
    # @return [Object]
    #
    def load_yaml(filename)
      new YAML.load_file(filename)
    end
  end
end
