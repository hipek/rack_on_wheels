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
      before { get '/test/new' }

      it 'returns text body' do
        expect(response.body).to eql('text')
      end
    end

    describe '#middlewares' do
      context 'when added' do
        before do
          described_class.middlewares << TestJsonResponseMiddleMiddleware
        end

        before { get '/test/new' }

        after { described_class.middlewares.clear }

        it 'has HTTP_ACCEPT in headers' do
          expect(response.headers['HTTP_ACCEPT'])
            .to eql('application/json')
        end
      end

      context 'when not added' do
        before { get '/test/new' }

        it 'doesn\'t have HTTP_ACCEPT in headers' do
          expect(response.headers['HTTP_ACCEPT'])
            .to be_nil
        end
      end
    end
  end
end
