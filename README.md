# OpenAPI

Validates request-response cycle against an [Open API (ex-Swagger v3+)][swagger] schema.

## Installation

Add this line to your application"s Gemfile:

```ruby
gem "open_api"
```

And then execute:

```shell
$ bundle
```

Or install it yourself as:

```shell
$ gem install open_api
```

## Synopsis

Provide a schema:

```yaml
# config/api_schema.yml
---
openapi: "3.0.0"
# ...
paths:
  /pets:
    get:
      operationId: listPets
      # ...
```

Wrap it into an instance of `OpenAPI` class:

```ruby
require "open_api"

API = OpenAPI.load_yaml "config/api_schema.yml"
```

Use it to validate request-response cycle (on either a server or a client):

```ruby
# Check parameters of a request against the schema
API[:listPets].request.validate! body: body, headers: headers, query: query

# Alternatively check rack env of a request against the schema
API[:listPets].request.validate! env

# Check a response against the schema
API[:listPets].response[200].validate! headers, body
```

Inspect schema definitions an examples to return them in corresponding [OPTIONS][options] requests:

```ruby
# Return an example of valid request
API[:listPets].request.example # => { headers: { ... }, body: ... }

# Return an example of valid response
API[:listPets].response[200].example # => { headers: { ... }, body: ... }

# Return schema definition as a hash
API[:listPets].schema
```

## Usage in a Rails Server

When providing an API (either public or private -- for the application's front-end) you need to:
- share the same schema between the server and its client
- ensure that a server follows the schema in requests and responses
- provide the client with a schema for every single operation via OPTIONS http(s) requests

Every change in a schema on a server side would authomatically affect its behavior. Any client can check its behaviour against the same schema, returned by corresponding OPTIONS.

Place the schema to config:

```yaml
# config/open_api.yml
---
# ...
```

Wrap the schema to the instance of `OpenAPI`. For example, you can define the method `Rails.application.open_api`:

```ruby
# config/initializers/open_api.rb
require "open_api/rails" # You must load it explicitly

Rails.application do
  def self.open_api
    # Notice the additional [.rails] method here
    @open_api ||= OpenAPI.rails.load_yaml("config/open_api.yml")
  end
end
```

Add routes for all the schema-defined OPERATIONS:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  Rails.application.open_api.set_options_routes(self)
end
```

Every route will return a schema in the json format for a corresponding operation. The full schema is returned in responce to the `OPTIONS /` request:

```bash
$ rake routes
              Prefix Verb      URI Pattern     Controller#Action
                     OPTIONS   /(.json)        OpenAPI::Web
                     OPTIONS   /pets(.json)    OpenAPI::Web
                     ...
```

Use the schema in a controller to check a request params against the schema:

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  rescue_from OpenAPI::Error do |error|
    # notice a plural `messages` here, which is an array of strings:
    head json: { errors: error.messages }, status: 400
  end
end

# app/controllers/pets_controller.rb
class PetsControlller < ApplicationController
  def index
    Rails.application.open_api[:listPets].request.validate! params
    # ...
  end
end
```

Ensure that a server responds in accordance to the schema. Unlike client-provided requests, there's no need to check server-provided responses in a run time. Instead, check responses in a request specifications:

```ruby
# spec/requests/list_pets_spec.rb

require "rails_helper"

RSpec.describe "Pets management", type: :request do
  let(:schema) { Rails.application.open_api }

  describe "listPets" do
    before { get "/pets" }

    it "fits the schema" do
      expect(response).to fit_open_api schema[:listPets]
    end
  end
end
```

## License

The gem is available as open source under the terms of the [MIT License][license].

[license]: http://opensource.org/licenses/MIT
[options]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/OPTIONS
