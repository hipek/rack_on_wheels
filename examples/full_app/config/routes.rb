RackOnWheels::Router.setup do
  get '/', 'welcome#index'
  get '/welcome', 'welcome#show'
end
