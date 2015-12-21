# encoding: utf-8

require 'spec_helper'

describe Yardstick, '.measure_string' do
  context 'with a string' do
    subject { described_class.measure_string("def foo;end\ndef bar;end") }

    it { should be_a(Yardstick::MeasurementSet) }

    it { should_not be_empty }
  end

  describe 'with no arguments' do
    it 'raises an exception' do
      expect { described_class.measure_string }
        .to raise_error(ArgumentError)
    end
  end
end
