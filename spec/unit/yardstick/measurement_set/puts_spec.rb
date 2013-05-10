require 'spec_helper'

describe Yardstick::MeasurementSet, '#puts' do
  let(:set)      { described_class.new([failed, successful]) }
  let(:document) { DocumentMock.new }

  let(:failed) do
    Class.new {
      def ok?; false; end

      def puts(io)
        io.puts('measurement info')
      end
    }.new
  end

  let(:successful) do
    Class.new {
      def ok?; true; end

      def puts(io)
        io.puts('measurement info')
      end
    }.new
  end

  describe 'with no arguments' do
    before do
      capture_stdout { set.puts }
    end

    it 'should output the summary' do
      @output.should == "measurement info\n" \
        "measurement info\n" \
        "\nYARD-Coverage: 50.0%  Success: 1  Failed: 1  Total: 2\n"
    end
  end

  describe 'with an object implementing #puts' do
    before do
      io = StringIO.new
      set.puts(io)
      io.rewind
      @output = io.read
    end

    it 'should output the summary' do
      @output.should == "measurement info\n" \
        "measurement info\n" \
        "\nYARD-Coverage: 50.0%  Success: 1  Failed: 1  Total: 2\n"
    end
  end
end
