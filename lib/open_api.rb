require "yaml"
require "dry-initializer"

# Specification-based API
#
# @example
#   API = OpenAPI["config/open_api.yml"]
#
#   API[:find_user].check_request(params)
#   API[:find_user].check_response(body)
#   API[:find_user].to_h
#
class OpenAPI
end
