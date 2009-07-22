require 'pathname'
require Pathname(__FILE__).dirname.expand_path.join('..', '..', 'spec_helper')

shared_examples_for 'measurement is successful' do
  before :all do
    @measurement = Yardstick::Measurement.new('successful', @docstring) { true }
  end
end

shared_examples_for 'measurement is skipped' do
  before :all do
    @measurement = Yardstick::Measurement.new('skipped', @docstring) { skip }
  end
end

shared_examples_for 'measurement is not successful' do
  before :all do
    @measurement = Yardstick::Measurement.new('not successful', @docstring) { false }
  end
end

shared_examples_for 'measurement is not implemented' do
  before :all do
    @measurement = Yardstick::Measurement.new('not implemented', @docstring) { todo }
  end
end

shared_examples_for 'measurement is warned' do
  before :all do
    $stderr = StringIO.new
    @response = @measurement.warn
    $stderr.rewind
    @output = $stderr.read
  end

  it 'should return nil' do
    @response.should be_nil
  end
end

describe Yardstick::Measurement do
  before :all do
    YARD.parse_string('def test; end')
    @docstring = YARD::Registry.all(:method).first.docstring
  end

  describe '.new' do
    before :all do
      @response = Yardstick::Measurement.new('test measurement', @docstring) { true }
    end

    it 'should return a Measurement' do
      @response.should be_kind_of(Yardstick::Measurement)
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

  describe '#warn' do
    describe 'when the measurement is successful' do
      it_should_behave_like 'measurement is successful'
      it_should_behave_like 'measurement is warned'

      it 'should not output a warning' do
        @output.should == ''
      end
    end

    describe 'when the measurement is skipped' do
      it_should_behave_like 'measurement is skipped'
      it_should_behave_like 'measurement is warned'

      it 'should not output a warning' do
        @output.should == ''
      end
    end

    describe 'when the measurement is not successful' do
      it_should_behave_like 'measurement is not successful'
      it_should_behave_like 'measurement is warned'

      it 'should output a warning' do
        @output.should == "(stdin):1: #test: not successful\n"
      end
    end

    describe 'when the measurement is not implemented' do
      it_should_behave_like 'measurement is not implemented'
      it_should_behave_like 'measurement is warned'

      it 'should output a warning' do
        @output.should == "(stdin):1: #test: not implemented\n"
      end
    end
  end
end
