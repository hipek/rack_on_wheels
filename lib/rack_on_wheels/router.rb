class RackOnWheels::Router
  class << self
    def setup
      yield self
    end

    def route(info)
    end
  end
end
