require 'spec_helper'

describe RackOnWheels do
  let(:request) do
    Rack::MockRequest.new(described_class.rack_app)
  end

  it 'has a version number' do
    expect(RackOnWheels::VERSION).not_to be nil
  end

  it 'returns json body' do
    expect(JSON.parse request.get("/").body).to eql("a"=>"b")
  end
end
