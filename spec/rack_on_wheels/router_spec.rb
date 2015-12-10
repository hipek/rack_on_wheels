require 'spec_helper'

describe RackOnWheels::Router do
  describe RackOnWheels::Router::Route do
    let(:route) do
      RackOnWheels.routes[:get].first
    end

    before do
      RackOnWheels::Router.setup do
        get '/users/new', 'users#new'
      end
    end

    after { RackOnWheels.routes.clear }

    it { expect(route.path).to eql '/users/new' }
    it { expect(route.action).to eql 'new' }
    it { expect(route.controller).to eql 'Users' }
  end
end
