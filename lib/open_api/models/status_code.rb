module OpenAPI::Models
  class StatusCode < Base
    param :code
    param :order
    param :regexp

    def match(status)
      return false unless @regexp === status.to_s
      block_given? ? yield : true
    end
    alias =~  match
    alias === match

    def self.call(status, parent)
      new(status, parent)
    end

    private

    def initialize(status, parent)
      code = status.to_s.downcase

      order = case code
              when /^[1-5]\d{2}$/ then 0
              when /^[1-5]xx$/    then 1
              when "default"      then 2
              else raise Error, "invalid status code '#{status}' for #{parent}"
              end

      regexp = [/^#{code}$/, /^#{code[0]}\d{2}$/, /^[1-5]\d{2}$/][order]

      super(code, order, regexp)
    end
  end
end
