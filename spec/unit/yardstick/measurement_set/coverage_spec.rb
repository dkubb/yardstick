require 'spec_helper'

describe Yardstick::MeasurementSet, '#coverage' do
  subject { set.coverage }

  context 'when there are no measurements' do
    let(:set) { described_class.new }

    it { should be(1) }
  end

  context 'when there are measurements' do
    let(:set)          { described_class.new([measurement1, measurement2]) }
    let(:measurement1) { double('measurement', :ok? => true)               }
    let(:measurement2) { double('measurement', :ok? => false)              }

    it { should be_a(Rational) }

    it { should eq(0.5) }
  end
end
