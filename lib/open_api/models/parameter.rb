module OpenAPI::Models
  #
  # Parameter of some [Operation]
  # @private
  #
  class Parameter < Base
    param  :parent
    option :name,       proc(&:to_s)
    option :in,         Location,   as: :location
    option :deprecated, Boolean,    default: -> { false }
    option :style,      Style,      optional: true
    option :required,   Boolean,    optional: true, reader: :private
    option :content,    MediaTypes, optional: true, reader: :private
    option :schema,  method(:Hash), optional: true,
                                    as: :default_schema,
                                    reader: :private
    option :allowEmptyValue,        optional: true,
                                    type:     Boolean,
                                    reader:   :private,
                                    as:       :empty

    def schema(format)
      content ? content.schema(format) : default_schema
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
