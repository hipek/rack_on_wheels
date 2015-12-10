class RackOnWheels::App
  class << self
    def call(env)
      [200, {}, ['{"a":"b"}']]
    end    
  end
end
