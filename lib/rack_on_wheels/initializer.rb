module RackOnWheels
  Initializer = Struct.new(:root) do
    def run
      load files 'config/routes.rb'
      load files 'app/controllers/**/*.rb'
    end

    def load(file_list)
      file_list.each { |f| require f }
    end

    def files(path)
      Dir[File.join(root, path)].sort
    end
  end
end
