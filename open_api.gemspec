Gem::Specification.new do |gem|
  gem.name     = "open_api"
  gem.version  = "0.0.1"
  gem.author   = "Andrew Kozin (nepalez)"
  gem.email    = "andrew.kozin@gmail.com"
  gem.homepage = "https://github.com/nepalez/knive"
  gem.summary  = "Tooling to build self-exposing specification-based APIs"
  gem.license  = "MIT"

  gem.files            = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.test_files       = gem.files.grep(/^spec/)
  gem.extra_rdoc_files = Dir["README.md", "LICENSE", "CHANGELOG.md"]

  gem.required_ruby_version = ">= 2.3"

  gem.add_runtime_dependency "dry-initializer", "~> 2.0"
  gem.add_runtime_dependency "json-schema"

  gem.add_development_dependency "rspec", "~> 3.0"
  gem.add_development_dependency "rspec-its"
  gem.add_development_dependency "rake", "> 10"
  gem.add_development_dependency "rubocop", "~> 0.42"
end
