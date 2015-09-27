# encoding: utf-8

require 'spec_helper'

describe Yardstick::MeasurementSet, '#initialize' do
  context 'with no arguments' do
    subject { described_class.new }

    it { should be_a(described_class) }

    it { should be_a(Enumerable) }

    it { should be_empty }
  end

  context 'with measurements' do
    subject { described_class.new([measurement]) }

    let(:measurement) { double('measurement') }

    it { should be_a(described_class) }

    it { should be_a(Enumerable) }

    it { should include(measurement) }
  end
end
