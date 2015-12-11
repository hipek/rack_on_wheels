module RackOnWheels
  class App
    class << self
      attr_accessor :controller, :request, :route

      def call(env)
        @request    = Rack::Request.new env
        @route      = RackOnWheels::Router.find_route request
        @controller = RackOnWheels::BaseController.build route, request

        set_body
        set_headers
        controller.response
      end

      def set_body
        controller.response.write controller.public_send route.action
      end

      def set_headers
        %w[HTTP_ACCEPT].each do |name|
          if request.env[name]
            controller.response.headers[name] = request.env[name]
          end
        end
      end
    end
  end
end
