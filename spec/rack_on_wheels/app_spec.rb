require 'spec_helper'

describe RackOnWheels::App do
  it { expect(described_class).to respond_to :call }
end
