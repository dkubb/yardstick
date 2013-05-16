require 'spec_helper'

describe Yardstick::MeasurementSet, '#failed' do
  subject { set.failed }

  context 'when no failed measurements' do
    let(:set) { described_class.new }

    it { should be(0) }
  end

  context 'when a failed measurement' do
    let(:set)         { described_class.new([measurement]) }
    let(:measurement) { mock('measurement', :ok? => false) }

    it { should be(1) }
  end

  context 'when a failed measurement with a successful measurement' do
    let(:set)          { described_class.new([measurement1, measurement2]) }
    let(:measurement1) { mock('measurement', :ok? => false) }
    let(:measurement2) { mock('measurement', :ok? => true) }

    it { should be(1) }
  end
end
