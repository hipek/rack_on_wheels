require 'rack_on_wheels/version'

require 'rack'
require 'json'

module RackOnWheels
  HTTP_METHODS = %i(post get put delete)

  require 'rack_on_wheels/app'
  require 'rack_on_wheels/router'
  require 'rack_on_wheels/base_controller'
  require 'rack_on_wheels/test_helper'
  require 'rack_on_wheels/initializer'
  require 'rack_on_wheels/errors'

  class << self
    attr_reader :routes, :middlewares

    def routes
      @routes ||= Hash.new { |hash, key| hash[key] = Set.new }
    end

    def middlewares
      @middlewares ||= []
    end

    def root
      if defined? APP_ROOT
        APP_ROOT
      else
        fail 'APP_ROOT is required to start the app'
      end
    end

    def initialize!
      RackOnWheels::Initializer.new(root).run
    end

    def application
      Rack::Builder.new do
        RackOnWheels.middlewares.each do |middleware|
          use middleware
        end
        run RackOnWheels::App
      end
    end

    def run
      Rack::Server.start app: application
    end
  end
end
