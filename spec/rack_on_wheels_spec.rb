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

  describe '#root' do
    context 'when APP_ROOT not set' do
      it { expect { described_class.root }.to raise_error StandardError }
    end

    context 'when APP_ROOT is set' do
      before { Object.const_set 'APP_ROOT', './' }

      after { Object.send :remove_const, 'APP_ROOT' }

      it { expect(described_class.root).to eql './' }
    end
  end

  describe '#run' do
    it 'starts server with rack app' do
      expect(Rack::Server).to receive(:start).with(app: kind_of(Rack::Builder))
    end

    after { described_class.run }
  end

  describe '#initialize!' do
    before do
      expect(described_class).to receive(:root) { Dir.pwd + '/spec/dummy' }
    end

    it 'requires routes and one contrller from dummy' do
      expect_any_instance_of(described_class::Initializer)
        .to receive(:require).twice
    end

    after { described_class.initialize! }
  end

  describe '#routes' do
    context 'default' do
      it 'has blank hash' do
        expect(described_class.routes).to eql({})
      end
    end

    context 'when key not present' do
      let(:list) do
        described_class.routes[:get]
      end

      it 'returns empty set' do
        expect(list).to be_empty
        expect(list).to be_kind_of Set
      end
    end
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
