module OpenAPI::Models
  # Converts stringified values to booleans
  Boolean = ->(v) { v.to_s == "true" }
end
