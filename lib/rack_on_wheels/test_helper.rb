module RackOnWheels
  module TestHelper
    attr_accessor :response

    def request
      Rack::MockRequest.new(RackOnWheels.application)
    end

    RackOnWheels::HTTP_METHODS.each do |name|
      define_method name do |path|
        @response = request.public_send name, path
      end
    end
  end
end
