$:.unshift File.expand_path('../../lib', __FILE__)
require 'rack_on_wheels'

RackOnWheels::Router.setup do |r|
  r.route '/users/new' => 'users#new'
end

class UsersController < RackOnWheels::BaseController
  def new
    'text'
  end
end

RackOnWheels.run
