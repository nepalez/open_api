module OpenAPI::Models
  #
  # Exception to be risen when model isn't valid
  #
  class Error < ::ArgumentError
    # @!attribute [r] args
    # @return [Object] arguments of the initializer
    attr_reader :args

    private

    def initialize(message, *args)
      super message
      @args = args
    end
  end
end
