require 'spec_helper'

describe Yardstick::MeasurementSet, '#total' do
  subject { set.total }

  let(:set)         { described_class.new([measurement]) }
  let(:measurement) { double('measurement')              }

  it { should be(1) }
end
