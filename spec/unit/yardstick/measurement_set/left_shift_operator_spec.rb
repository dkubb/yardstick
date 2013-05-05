require 'spec_helper'

describe Yardstick::MeasurementSet, '#<<' do
  subject { set << measurement }

  let(:set)         { described_class.new }
  let(:measurement) { mock('measurement') }

  it { should be(set) }
  it { should include(measurement) }
end
