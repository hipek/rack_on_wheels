$:.unshift File.expand_path('../../lib', __FILE__)
require 'rack_on_wheels'

RackOnWheels::Router.setup do
  get '/', 'users#index'
  get '/users/new', 'users#new'
  get '/users', 'users#show'
  get '/comments', 'comments#index'
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
