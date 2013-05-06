require 'spec_helper'

describe Yardstick::DocumentSet, '#measure' do
  subject { described_class.new([document1, document2]).measure(config) }

  let(:document1) { mock('document1') }
  let(:document2) { mock('document2') }
  let(:config)    { mock('config') }

  let(:measurement1) { mock('measurement') }
  let(:measurement2) { mock('measurement') }

  before do
    Yardstick::Document.
      should_receive(:measure).
      with(document1, config).
      and_return(Yardstick::MeasurementSet.new([measurement1]))

    Yardstick::Document.
      should_receive(:measure).
      with(document2, config).
      and_return(Yardstick::MeasurementSet.new([measurement2]))
  end

  it { should be_a(Yardstick::MeasurementSet) }

  it { should include(measurement1, measurement2) }
  its(:length) { should be(2) }
end
