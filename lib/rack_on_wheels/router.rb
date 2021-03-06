module RackOnWheels
  class Router
    class Route
      attr_accessor :controller, :action, :path, :to, :params

      def initialize(path, to)
        @path = path
        @to   = to
        parse_to to
      end

      def parse_to(name)
        self.controller, self.action = name.split('#')
        controller.capitalize!
      end
    end

    Matcher = Struct.new(:path, :routes) do
      def detect
        routes.detect do |route|
          case route.path
          when Regexp then path.match route.path
          when %r{\/\:\w+\/?} then !build_params(route).empty?
          else
            route.path == path
          end
        end
      end

      def build_params(route)
        list = route.path.split('/').zip path.split('/')
        return {} if paths_not_match?(list)
        route.params = map_params list
      end

      def paths_not_match?(list)
        list.any? { |pair| !pair[0].match(/\:/) && pair[1].nil? }
      end

      def map_params(list)
        list.map do |pair|
          if pair.uniq.size == 2 && pair[0].match(/\:/)
            pair[0] = pair[0].tr(':', '').to_sym
            pair
          end
        end.compact.to_h
      end
    end

    class << self
      def setup(&blk)
        new.setup(&blk)
      end

      def find_route(request)
        Matcher.new(
          request.path_info,
          routes[request.request_method.downcase.to_sym]
        ).detect || not_found_error(request)
      end

      def not_found_error(request)
        fail(
          RackOnWheels::PageNotFoundError,
          request.path_info + ' 404 - Not found'
        )
      end

      def routes
        RackOnWheels.routes
      end
    end

    def setup(&blk)
      instance_eval(&blk)
    end

    RackOnWheels::HTTP_METHODS.each do |name|
      define_method name do |path, to|
        add_route name, path, to
      end
    end

    protected

    def add_route(method, path, to)
      routes[method] << Route.new(path, to)
    end

    def routes
      self.class.routes
    end
  end
end
