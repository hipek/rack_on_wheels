$:.unshift File.expand_path('../../lib', __FILE__)
require 'rack_on_wheels'

RackOnWheels::Router.setup do
  get '/', 'users#index'
  get '/users/new', 'users#new'
end

class UsersController < RackOnWheels::BaseController
  def new
    'text'
  end

  def index
    'index'
  end
end

RackOnWheels.run
