# encoding: utf-8

require 'spec_helper'

describe Yardstick::MeasurementSet do
  before do
    YARD.parse_string('def test; end')

    @document   = mock('document')
    @rule_class = ValidRule

    @measurement  = Yardstick::Measurement.new(@document, @rule_class)
    @measurements = Yardstick::MeasurementSet.new
  end

  it 'should be Enumerable' do
    Yardstick::MeasurementSet.new.should be_kind_of(Enumerable)
  end

  describe '.new' do
    describe 'with no arguments' do
      before do
        @measurements = Yardstick::MeasurementSet.new
      end

      it 'should return a MeasurementSet' do
        @measurements.should be_kind_of(Yardstick::MeasurementSet)
      end

      it 'should be empty' do
        @measurements.should be_empty
      end
    end

    describe 'with Measurements' do
      before do
        @measurements = Yardstick::MeasurementSet.new([ @measurement ])
      end

      it 'should return a MeasurementSet' do
        @measurements.should be_kind_of(Yardstick::MeasurementSet)
      end

      it 'should include the Measurements' do
        @measurements.should include(@measurement)
      end
    end
  end

  describe '#<<' do
    describe 'with a new Measurement' do
      before do
        @response = @measurements << @measurement
      end

      it 'should return self' do
        @response.should be_equal(@measurements)
      end

      it 'should append the Measurement' do
        @measurements.to_a.last.should equal(@measurement)
      end
    end

    describe 'with an equivalent Measurement' do
      before do
        @measurements << @measurement
        @measurements.to_a.should == [ @measurement ]

        @response = @measurements << Yardstick::Measurement.new(@document, ValidRule)
      end

      it 'should return self' do
        @response.should be_equal(@measurements)
      end

      it 'should not append the Measurement again' do
        @measurements.to_a.should == [ @measurement ]
      end
    end
  end

  describe '#merge' do
    before do
      @other = Yardstick::MeasurementSet.new
      @other << @measurement

      @response = @measurements.merge(@other)
    end

    it 'should return self' do
      @response.should be_equal(@measurements)
    end

    it 'should merge the other Measurements' do
      @measurements.should include(*@other)
    end
  end

  describe '#each' do
    before do
      @measurements << @measurement

      @yield = []

      @response = @measurements.each { |*args| @yield << args }
    end

    it 'should return self' do
      @response.should be_equal(@measurements)
    end

    it 'should yield measurements' do
      @yield.should eql([ [ @measurement ] ])
    end
  end

  describe '#empty?' do
    describe 'when there are no measurements' do
      it 'should return true' do
        @measurements.empty?.should be_true
      end
    end

    describe 'when there are measurements' do
      before do
        @measurements << @measurement
      end

      it 'should return false' do
        @measurements.empty?.should be_false
      end
    end
  end

  describe '#include?' do
    describe 'when provided an included measurement' do
      before do
        @measurements << @measurement

        @response = @measurements.include?(@measurement)
      end

      it 'should return true' do
        @response.should be_true
      end
    end

    describe 'when provided an excluded measurement' do
      before do
        @response = @measurements.include?(@measurement)
      end

      it 'should return false' do
        @response.should be_false
      end
    end
  end

  describe '#index' do
    describe 'when provided an included measurement' do
      before do
        @measurements << @measurement

        @response = @measurements.index(@measurement)
      end

      it 'should return the index' do
        @response.should eql(0)
      end
    end

    describe 'when provided an excluded measurement' do
      before do
        @response = @measurements.index(@measurement)
      end

      it 'should return nil' do
        @response.should == nil
      end
    end
  end

  describe '#total' do
    before do
      @measurements << @measurement
    end

    it 'should return the number of total measurements' do
      @measurements.total.should eql(1)
    end
  end

  describe '#successful' do
    before do
      @measurements << @measurement
    end

    it 'should return the number of successful measurements' do
      @measurements.successful.should eql(1)
    end
  end

  describe '#failed' do
    before do
      @measurements << @measurement
    end

    it 'should return the number of failed measurements' do
      @measurements.failed.should eql(0)
    end
  end

  describe '#coverage' do
    describe 'when there are no measurements' do
      it 'should return 1' do
        @measurements.coverage.should eql(1)
      end
    end

    describe 'when there are measurements' do
      before do
        @response = @measurements << @measurement
      end

      it 'should return a Rational' do
        @measurements.coverage.should be_kind_of(Rational)
      end

      it 'should return the expected value' do
        @measurements.coverage.should == 1
      end
    end
  end

  describe '#puts' do
    before do
      @document.stub(:file) { "(stdin)" }
      @document.stub(:line) { 1 }
      @document.stub(:path) { "#test" }

      @measurements << Yardstick::Measurement.new(@document, InvalidRule)
    end

    describe 'with no arguments' do
      before do
        capture_stdout { @measurements.puts }
      end

      it 'should output the summary' do
        @output.should == "(stdin):1: #test: not successful\n" \
          "\nYARD-Coverage: 0.0%  Success: 0  Failed: 1  Total: 1\n"
      end
    end

    describe 'with an object implementing #puts' do
      before do
        io = StringIO.new
        @measurements.puts(io)
        io.rewind
        @output = io.read
      end

      it 'should output the summary' do
        @output.should == "(stdin):1: #test: not successful\n" \
          "\nYARD-Coverage: 0.0%  Success: 0  Failed: 1  Total: 1\n"
      end
    end
  end
end
