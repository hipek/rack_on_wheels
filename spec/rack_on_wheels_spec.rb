require 'spec_helper'

class TestController < RackOnWheels::BaseController
  def new
    'text'
  end
end

describe RackOnWheels do
  let(:request) do
    Rack::MockRequest.new(described_class.rack_app)
  end

  it 'has a version number' do
    expect(RackOnWheels::VERSION).not_to be nil
  end

  it 'has blank hash with routes' do
    expect(described_class.routes).to eql({})
  end

  describe 'GET request' do
    before do
      RackOnWheels::Router.setup do
        get '/test/new', 'test#new'
      end
    end

    it 'returns text body' do
      expect(request.get('/users/new').body).to eql('text')
    end
  end
end
