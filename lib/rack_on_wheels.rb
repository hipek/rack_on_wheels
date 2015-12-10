require "rack_on_wheels/version"

require 'rack'

require 'rack_on_wheels/app'
require 'rack_on_wheels/router'
require 'rack_on_wheels/base_controller'

module RackOnWheels
  class << self
    def root
      File.expand_path('../../', __FILE__)
    end

    def rack_app
      Rack::Builder.new do
        run RackOnWheels::App
      end
    end

    def run
      Rack::Server.start app: rack_app
    end
  end
end
