require 'spec_helper'

shared_examples_for 'measurement is successful' do
  before do
    @measurement = Yardstick::Measurement.new('successful', @docstring) { true }
  end
end

shared_examples_for 'measurement is skipped' do
  before do
    @measurement = Yardstick::Measurement.new('skipped', @docstring) { skip }
  end
end

shared_examples_for 'measurement is not successful' do
  before do
    @measurement = Yardstick::Measurement.new('not successful', @docstring) { false }
  end
end

shared_examples_for 'measurement is not implemented' do
  before do
    @measurement = Yardstick::Measurement.new('not implemented', @docstring) { todo }
  end
end

shared_examples_for 'measurement is displayed' do
  before do
    capture_stdout { @measurement.puts }
  end
end

shared_examples_for 'measurement is sent to object' do
  before do
    io = StringIO.new
    @measurement.puts(io)
    io.rewind
    @output = io.read
  end
end

describe Yardstick::Measurement do
  before do
    YARD.parse_string(<<-RUBY)
      class MeasurementTest
        def test
        end
      end
    RUBY

    @docstring = YARD::Registry.all(:method).first.docstring
  end

  describe '.new' do
    before do
      @measurement = Yardstick::Measurement.new('test measurement', @docstring) { true }
    end

    it 'should return a Measurement' do
      @measurement.should be_kind_of(Yardstick::Measurement)
    end
  end

  describe '#description' do
    before do
      @description = 'test measurement'

      @measurement = Yardstick::Measurement.new(@description, @docstring) { true }
    end

    it 'should return the expected description' do
      @measurement.description.should equal(@description)
    end
  end

  describe '#ok?' do
    describe 'when the measurement is successful' do
      it_should_behave_like 'measurement is successful'

      it 'should return true' do
        @measurement.ok?.should be_true
      end
    end

    describe 'when the measurement is skipped' do
      it_should_behave_like 'measurement is skipped'

      it 'should return true' do
        @measurement.ok?.should be_true
      end
    end

    describe 'when the measurement is not successful' do
      it_should_behave_like 'measurement is not successful'

      it 'should return false' do
        @measurement.ok?.should be_false
      end
    end

    describe 'when the measurement is not implemented' do
      it_should_behave_like 'measurement is not implemented'

      it 'should return false' do
        @measurement.ok?.should be_false
      end
    end
  end

  describe '#skip?' do
    describe 'when the measurement is successful' do
      it_should_behave_like 'measurement is successful'

      it 'should return false' do
        @measurement.skip?.should be_false
      end
    end

    describe 'when the measurement is skipped' do
      it_should_behave_like 'measurement is skipped'

      it 'should return true' do
        @measurement.skip?.should be_true
      end
    end

    describe 'when the measurement is not successful' do
      it_should_behave_like 'measurement is not successful'

      it 'should return false' do
        @measurement.skip?.should be_false
      end
    end

    describe 'when the measurement is not implemented' do
      it_should_behave_like 'measurement is not implemented'

      it 'should return false' do
        @measurement.skip?.should be_false
      end
    end
  end

  describe '#todo?' do
    describe 'when the measurement is successful' do
      it_should_behave_like 'measurement is successful'

      it 'should return false' do
        @measurement.todo?.should be_false
      end
    end

    describe 'when the measurement is skipped' do
      it_should_behave_like 'measurement is skipped'

      it 'should return false' do
        @measurement.todo?.should be_false
      end
    end

    describe 'when the measurement is not successful' do
      it_should_behave_like 'measurement is not successful'

      it 'should return false' do
        @measurement.todo?.should be_false
      end
    end

    describe 'when the measurement is not implemented' do
      it_should_behave_like 'measurement is not implemented'

      it 'should return true' do
        @measurement.todo?.should be_true
      end
    end
  end

  describe '#puts' do
    describe 'with no arguments' do
      describe 'when the measurement is successful' do
        it_should_behave_like 'measurement is successful'
        it_should_behave_like 'measurement is displayed'

        it 'should not display any output' do
          @output.should == ''
        end
      end

      describe 'when the measurement is skipped' do
        it_should_behave_like 'measurement is skipped'
        it_should_behave_like 'measurement is displayed'

        it 'should not display any output' do
          @output.should == ''
        end
      end

      describe 'when the measurement is not successful' do
        it_should_behave_like 'measurement is not successful'
        it_should_behave_like 'measurement is displayed'

        it 'should display output' do
          @output.should == "(stdin):2: MeasurementTest#test: not successful\n"
        end
      end

      describe 'when the measurement is not implemented' do
        it_should_behave_like 'measurement is not implemented'
        it_should_behave_like 'measurement is displayed'

        it 'should display output' do
          @output.should == "(stdin):2: MeasurementTest#test: not implemented\n"
        end
      end
    end

    describe 'with an object implementing #puts' do
      describe 'when the measurement is successful' do
        it_should_behave_like 'measurement is successful'
        it_should_behave_like 'measurement is sent to object'

        it 'should not display any output' do
          @output.should == ''
        end
      end

      describe 'when the measurement is skipped' do
        it_should_behave_like 'measurement is skipped'
        it_should_behave_like 'measurement is sent to object'

        it 'should not display any output' do
          @output.should == ''
        end
      end

      describe 'when the measurement is not successful' do
        it_should_behave_like 'measurement is not successful'
        it_should_behave_like 'measurement is sent to object'

        it 'should display output' do
          @output.should == "(stdin):2: MeasurementTest#test: not successful\n"
        end
      end

      describe 'when the measurement is not implemented' do
        it_should_behave_like 'measurement is not implemented'
        it_should_behave_like 'measurement is sent to object'

        it 'should display output' do
          @output.should == "(stdin):2: MeasurementTest#test: not implemented\n"
        end
      end
    end
  end
end
