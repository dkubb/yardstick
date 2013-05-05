require 'spec_helper'

describe Yardstick::MeasurementSet, '#successful' do
  subject { set.successful }

  let(:set)          { described_class.new([measurement1, measurement2]) }
  let(:measurement1) { mock('measurement', :ok? => true) }
  let(:measurement2) { mock('measurement', :ok? => false) }

  it { should be(1) }
end
