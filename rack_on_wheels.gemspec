# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack_on_wheels/version'

Gem::Specification.new do |spec|
  spec.name          = "rack_on_wheels"
  spec.version       = RackOnWheels::VERSION
  spec.authors       = ["Jacek Hiszpanski"]
  spec.email         = ["j.hiszpanski@gmail.com"]

  spec.summary       = %q{Simple framework base on rack.}
  spec.description   = %q{Simple framework base on rack.}
  spec.homepage      = "https://github.com/hipek/rack_on_wheels.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rack', '~> 1.6.4'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec',   '~> 3.4.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov', '~> 0.10.0'
end
