$:.unshift File.expand_path('../../lib', __FILE__)
require 'rack_on_wheels'

RackOnWheels::Router.setup do
  get '/', 'users#index'
  get '/users/new', 'users#new'
  get '/users/:id/edit', 'users#edit'
  get '/users', 'users#show'
  get '/comments', 'comments#index'
end

class UsersController < RackOnWheels::BaseController
  def new
    'text'
  end

  def edit
    "params[:id] => #{params[:id]}"
  end

  def index
    'Welcome on index page'
  end
end

# Add cusom middleware
# RackOnWheels.middlewares << CustomMiddleware

RackOnWheels.run
