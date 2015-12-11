require 'spec_helper'

describe RackOnWheels::BaseController do
  it { expect(subject.response).to be_instance_of(Rack::Response) }

  describe '#render' do
    before do
      subject.render('text')
    end

    it 'adds content to body' do
      expect(subject.response.body).to eql ['text']
    end
  end

  describe '#build' do
    class MyTestController < RackOnWheels::BaseController
    end

    let(:request) { double(:request) }
    let(:controller) do
      described_class.build double(controller: 'MyTest'), request
    end

    it 'returns instance of controller' do
      expect(controller).to be_kind_of described_class
    end

    it 'has request' do
      expect(controller.request).to eql request
    end
  end
end
