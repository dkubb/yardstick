require 'spec_helper'

describe Yardstick::MeasurementSet, '#empty?' do
  subject { set.empty? }

  context 'when there are no measurements' do
    let(:set) { described_class.new }

    it { should be(true) }
  end

  context 'when there are measurements' do
    let(:set) { described_class.new([mock('measurement')]) }

    it { should be(false) }
  end
end
