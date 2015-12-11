module RackOnWheels
  module TestHelper
    def request
      Rack::MockRequest.new(RackOnWheels.application)
    end

    def response
      @response
    end

    RackOnWheels::HTTP_METHODS.each do |name|
      define_method name do |path|
        @response = request.public_send name, path
      end
    end
  end
end
