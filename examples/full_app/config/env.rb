require 'bundler/setup'
require 'rack_on_wheels'

APP_ROOT = File.expand_path('../../', __FILE__)

# Add custom middlewares (uncomment below line)
# RackOnWheels.middlewares << CustomMiddleware

RackOnWheels.initialize!
