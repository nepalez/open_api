module OpenAPI::Models
  #
  # Parameter of some [Operation]
  # @private
  #
  class Parameter < Base
    BOOLEAN = proc { |value| value.to_s == "true" }

    param  :operation
    option :name,       proc(&:to_s)
    option :in,         Location,      as: :location
    option :deprecated, BOOLEAN,       default: -> { false }
    option :required,   BOOLEAN,       optional: true, reader: :private
    option :content,    MediaTypes,    optional: true
    option :schema,     method(:Hash), optional: true
    option :style,      Style,         optional: true
    option :allowEmptyValue,           optional: true,
                                       type:     BOOLEAN,
                                       reader:   :private,
                                       as:       :empty

    def find_schema(format)
      content ? content.schema(format) : schema
    end

    def query?
      location.query?
    end

    def path?
      location.path?
    end

    def header?
      location.header?
    end

    def cookie?
      location.cookie?
    end

    def required?
      location.required? | required
    end

    def empty?
      !query? | empty
    end
  end
end
