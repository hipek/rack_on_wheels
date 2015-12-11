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

  describe RackOnWheels::Router::Matcher do
    let(:welcome_route) do
      RackOnWheels::Router::Route.new(
        '/', 'welcome#show'
      )
    end
    let(:route) do
      RackOnWheels::Router::Route.new(
        path_def, 'test#index'
      )
    end

    subject do
      described_class.new path_req, [route, welcome_route]
    end

    context 'when route path definition is /users' do
      let(:path_def) { '/users' }
      let(:path_req) { '/users' }

      it { expect(subject.detect).to eql route }

      context 'when path_req is /whatever' do
        let(:path_req) { '/whatever' }

        it { expect(subject.detect).to be_nil }
      end
    end

    context 'when route path definition is /users/:id' do
      let(:path_def) { '/users/:id' }
      let(:path_req) { '/users/12' }
      let(:found_route) { subject.detect }

      it { expect(found_route).to eql route }
      it { expect(found_route.params).to eql(id: '12') }
    end

    context 'when route path definition is /users/:user_id/comments/:id' do
      let(:path_def) { '/users/:user_id/comments/:id' }
      let(:path_req) { '/users/12/comments/13' }
      let(:found_route) { subject.detect }

      it { expect(found_route).to eql route }
      it { expect(found_route.params).to eql(user_id: '12', id: '13') }

      context 'when path_req is /users/12' do
        let(:path_req) { '/users/12' }

        it { expect(subject.detect).to be_nil }
      end
    end
  end
end
