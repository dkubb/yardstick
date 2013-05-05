require 'spec_helper'

describe Yardstick::MeasurementSet, '#include?' do
  subject { set.include?(measurement) }

  let(:measurement) { mock('measurement') }

  context 'when provided an included measurement' do
    let(:set) { described_class.new([measurement]) }

    it { should be(true) }
  end

  context 'when provided an excluded measurement' do
    let(:set) { described_class.new }

    it { should be(false) }
  end
end
