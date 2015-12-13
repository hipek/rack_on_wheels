module RackOnWheels
  BaseController = Struct.new(:request, :route) do
    class << self
      def build(route, request)
        const_get("#{route.controller}Controller").new(request, route)
      rescue NameError
        raise(
          RackOnWheels::ControllerNotFoundError,
          "500 - controller '#{route.controller}' not found"
        )
      end
    end

    def response
      @response ||= Rack::Response.new
    end

    def render(data)
      response.write data
    end

    def exec_action
      public_send route.action
    rescue NoMethodError
      raise(
        RackOnWheels::ActionNotFoundError,
        "500 - action '#{route.action}' not found" \
        " in controller '#{route.controller}'"
      )
    end
  end
end
