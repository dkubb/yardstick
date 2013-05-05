require 'spec_helper'

describe Yardstick::MeasurementSet, '#index' do
  subject { set.index(measurement) }

  let(:measurement) { mock('measurement') }

  context 'when provided an included measurement' do
    let(:set) { described_class.new([measurement]) }

    it { should be(0) }
  end

  context 'when provided an excluded measurement' do
    let(:set) { described_class.new }

    it { should be_nil }
  end
end
