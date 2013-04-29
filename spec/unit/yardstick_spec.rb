# encoding: utf-8

require 'spec_helper'

describe Yardstick do
  describe '.measure' do
    describe 'with no arguments' do
      before :all do
        @measurements = Yardstick.measure
      end

      it_should_behave_like 'measured itself'
    end

    describe 'with a Config' do
      before :all do
        config = Yardstick::Config.new(:path => Yardstick::ROOT.join('lib', 'yardstick.rb'))
        @measurements = Yardstick.measure(config)
      end

      it_should_behave_like 'measured itself'
    end
  end

  describe '.measure_string' do
    describe 'with a String' do
      before do
        @measurements = Yardstick.measure_string('def test; end')
      end

      it 'should return a MeasurementSet' do
        @measurements.should be_kind_of(Yardstick::MeasurementSet)
      end

      it 'should be non-empty' do
        @measurements.should_not be_empty
      end
    end

    describe 'with no arguments' do
      it 'should raise an exception' do
        lambda {
          Yardstick.measure_string
        }.should raise_error(ArgumentError)
      end
    end
  end
end
