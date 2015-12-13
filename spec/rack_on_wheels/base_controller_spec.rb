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

  describe 'with defined MyTestController' do
    class MyTestController < RackOnWheels::BaseController
    end

    let(:request) { double(:request) }

    describe '#build' do
      let(:controller) do
        described_class.build double(controller: 'MyTest'), request
      end

      it 'returns instance of controller' do
        expect(controller).to be_kind_of described_class
      end

      it 'has request' do
        expect(controller.request).to eql request
      end

      context 'when controller not defined' do
        subject do
          described_class.build double(controller: 'Other'), request
        end

        it 'raises error' do
          expect { subject }
            .to raise_error RackOnWheels::ControllerNotFoundError
        end
      end
    end

    describe '#exec_action' do
      let(:controller) do
        described_class.build(
          double(controller: 'MyTest', action: :new),
          request
        )
      end

      context 'when action not defined' do
        it 'raise error' do
          expect { controller.exec_action }
            .to raise_error RackOnWheels::ActionNotFoundError
        end
      end
    end
  end
end
