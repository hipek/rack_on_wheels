require 'spec_helper'

describe RackOnWheels::App do
  it { expect(described_class).to respond_to :call }

  let(:env) do
    {}
  end

  describe '#call' do
    before do
      allow(described_class).to receive(:puts)
    end

    [
      StandardError,
      RackOnWheels::ControllerNotFoundError,
      RackOnWheels::ActionNotFoundError
    ].each do |err|
      context "when #{err}" do
        before do
          expect(described_class).to receive(:perform)
            .with(env).and_raise err
        end

        it 'responses with 500 error' do
          expect(described_class.call(env).status).to eql 500
        end
      end
    end

    context 'when PageNotFoundError' do
      before do
        expect(described_class).to receive(:perform)
          .with(env).and_raise RackOnWheels::PageNotFoundError
      end

      it 'responses with 404 error' do
        expect(described_class.call(env).status).to eql 404
      end
    end
  end
end
