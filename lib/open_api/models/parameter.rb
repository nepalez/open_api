module OpenAPI::Models
  #
  # Parameter of some [Operation]
  # @private
  #
  class Parameter < Base
    param  :parent
    option :name,       proc(&:to_s)
    option :in,         Location,      as: :location
    option :deprecated, Boolean,       default: -> { false }
    option :required,   Boolean,       optional: true, reader: :private
    option :content,    MediaTypes,    optional: true
    option :schema,     method(:Hash), optional: true
    option :style,      Style,         optional: true
    option :allowEmptyValue,           optional: true,
                                       type:     Boolean,
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
