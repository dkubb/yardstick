require 'pathname'
require Pathname(__FILE__).dirname.expand_path.join('..', 'spec_helper')

describe Yardstick do
  describe '.measure' do
    describe 'with no arguments' do
      before :all do
        @measurements = Yardstick.measure
      end

      it_should_behave_like 'measured itself'
    end

    describe 'with a String path' do
      before :all do
        @measurements = Yardstick.measure(Yardstick::ROOT.join('lib', 'yardstick.rb').to_s)
      end

      it_should_behave_like 'measured itself'
    end

    describe 'with a Pathname' do
      before :all do
        @measurements = Yardstick.measure(Yardstick::ROOT.join('lib', 'yardstick.rb'))
      end

      it_should_behave_like 'measured itself'
    end

    describe 'with an Array of String objects' do
      before :all do
        @measurements = Yardstick.measure([ Yardstick::ROOT.join('lib', 'yardstick.rb').to_s ])
      end

      it_should_behave_like 'measured itself'
    end

    describe 'with an Array of Pathname objects' do
      before :all do
        @measurements = Yardstick.measure([ Yardstick::ROOT.join('lib', 'yardstick.rb') ])
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
        }.should raise_error(ArgumentError, RUBY_PLATFORM =~ /java/ ? 'wrong # of arguments(0 for 1)' : 'wrong number of arguments (0 for 1)')
      end
    end
  end
end
