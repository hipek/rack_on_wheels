$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
require 'rack_on_wheels'

RSpec.configure do |config|
  config.include RackOnWheels::TestHelper
end
