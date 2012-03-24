$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'fakeweb'
require 'mailup'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  # Include Savon test helpers
  config.include Savon::Spec::Macros
  # Fakeweb setup
  config.before(:each) do
    FakeWeb.clean_registry
  end
end