class RackOnWheels::Router
  class Route
    attr_accessor :controller, :action,
      :path, :to, :opts

    def initialize(path, to, opts = nil)
      @path, @to = path, to
      @opts = opts || {}
      parse_to to
    end

    def parse_to(name)
      self.controller, self.action = name.split('#')
      controller.capitalize!
    end
  end

  class << self
    def setup(&blk)
      new.setup &blk
    end

    def find_route(request)
      request.path_info
      routes[request.request_method.downcase.to_sym].first
    end

    def routes
      RackOnWheels.routes
    end
  end

  def setup(&blk)
    instance_eval &blk
  end

  %i(post get put delete).each do |name|
    define_method name do |path, to, *opts|
      add_route name, path, to, opts.first
    end
  end

  protected

  def add_route(method, path, to, opts)
    routes[method] << Route.new(path, to, opts)
  end

  def routes
    self.class.routes
  end
end
