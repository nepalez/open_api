module OpenAPI::Models
  #
  # Enumerable collection of named [Parameter]-s describing a response headers
  # @see https://swagger.io/specification/#operationObject
  # @private
  #
  class Headers < Parameters
    private

    def initialize(data, parent)
      @parent = parent
      @list = data.map do |name, item|
        if Parameter === item
          item
        else
          item = Array(item).map { |key, val| [key.to_sym, val] }.to_h
          Parameter.new(parent, name: name, in: "header", **item)
        end
      end
    end
  end
end
