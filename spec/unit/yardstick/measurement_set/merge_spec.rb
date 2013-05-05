require 'spec_helper'

describe Yardstick::MeasurementSet, '#merge' do
  subject { set.merge(other) }

  let(:set)         { described_class.new }
  let(:other)       { described_class.new([measurement]) }
  let(:measurement) { mock('measurement') }

  it { should be(set) }
  it { should include(*other) }
end
