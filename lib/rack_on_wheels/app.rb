module RackOnWheels
  class App
    class << self
      def call(env)
        request = Rack::Request.new env
        route = RackOnWheels::Router.find_route request

        controller = RackOnWheels::BaseController.build route, request
        controller.response.write controller.public_send route.action
        controller.response
      end
    end
  end
end
