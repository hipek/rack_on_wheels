class WelcomeController < RackOnWheels::BaseController
  def index
    'Welcome on index page'
  end

  def show
    { show: 'as json' }.to_json
  end
end
