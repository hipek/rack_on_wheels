class RackOnWheels::BaseController < Struct.new(:request)
  class << self
    def build(route, request)
      const_get("#{route.controller}Controller").new(request)
    end
  end

  def response
    @response ||= Rack::Response.new
  end

  def render(data)
    response.write data
  end
end
