require 'rspec'
require 'fakeweb'
require 'savon_spec'
require 'mailup'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
#Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  # Include Savon test helpers
  config.include Savon::Spec::Macros
  # Fakeweb setup
  config.before(:each) do
    FakeWeb.clean_registry
  end
end