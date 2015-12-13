# RackOnWheels

Simple framework to build web applications base on rack.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack_on_wheels'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack_on_wheels

## Usage

Start example app:

    ruby examples/single.rb

Go to http://localhost:8080/ to see the page

TO full app example from examples go to

    examples/full_app

and run:

    bundle install

To start server use:

    bundle exec thin start

Go to http://localhost:3000/

## How to test controller

Include test helper in spec helper:

    RSpec.configure do |config|
      config.include RackOnWheels::TestHelper
    end

Then use

    describe 'test' do
      before { get '/test/new' }

      it { expect(response).not_to eql nil }
    end


## Development

Run unit tests:

    bundle exec rake

Run rubocop:

    bundle exec rake rubocop

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hipek/rack_on_wheels.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

