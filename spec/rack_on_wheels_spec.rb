require 'spec_helper'

class TestController < RackOnWheels::BaseController
  def new
    'text'
  end
end

class TestJsonResponseMiddleMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    env['HTTP_ACCEPT'] = 'application/json'
    @app.call env
  end
end

describe RackOnWheels do
  let(:request) do
    Rack::MockRequest.new(described_class.application)
  end

  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  it 'has blank hash with routes' do
    expect(described_class.routes).to eql({})
  end

  it 'has blank list of middlewares' do
    expect(described_class.middlewares).to eql([])
  end

  describe 'with route' do
    before do
      described_class::Router.setup do
        get '/test/new', 'test#new'
      end
    end

    describe 'GET request' do
      it 'returns text body' do
        expect(request.get('/users/new').body).to eql('text')
      end
    end

    describe '#middlewares' do
      before do
        described_class.middlewares << TestJsonResponseMiddleMiddleware
      end

      after { described_class.middlewares.clear }

      it 'has HTTP_ACCEPT in headers' do
        expect(request.get('/test/new').headers['HTTP_ACCEPT'])
          .to eql('application/json')
      end
    end
  end
end
