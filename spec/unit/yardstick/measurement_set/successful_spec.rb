# encoding: utf-8

require 'spec_helper'

describe Yardstick::MeasurementSet, '#successful' do
  subject { set.successful }

  let(:set)          { described_class.new([measurement1, measurement2]) }
  let(:measurement1) { double('measurement', ok?: true)               }
  let(:measurement2) { double('measurement', ok?: false)              }

  it { should be(1) }
end
