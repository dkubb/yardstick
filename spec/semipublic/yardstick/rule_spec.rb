require 'pathname'
require Pathname(__FILE__).dirname.expand_path.join('..', '..', 'spec_helper')

describe Yardstick::Rule do
  describe '#==' do
    describe 'when rules are equivalent' do
      before do
        @rule  = Yardstick::Rule.new('test rule') { true }
        @other = Yardstick::Rule.new('test rule') { true }
      end

      it 'should return true' do
        (@rule == @other).should be_true
      end
    end

    describe 'when rules are not equivalent' do
      before do
        @rule  = Yardstick::Rule.new('test rule')  { true }
        @other = Yardstick::Rule.new('other rule') { true }
      end

      it 'should return false' do
        (@rule == @other).should be_false
      end
    end
  end
end
