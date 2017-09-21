require "open_api"
require "rspec/its"

begin
  require "pry"
rescue StandardError
  nil
end

Dir[File.expand_path("spec/support/**/*.rb")].each { |file| require file }

RSpec.configure do |config|
  config.order = :random
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  # Prepare the Test namespace for constants defined in specs
  config.around(:each) do |example|
    Test = Class.new(Module)
    example.run
    Object.send :remove_const, :Test
  end

  config.warnings = true
end
