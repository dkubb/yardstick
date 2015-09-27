# encoding: utf-8

require 'spec_helper'

describe Yardstick::MeasurementSet, '#puts' do
  let(:document) { DocumentMock.new }

  let(:set) do
    described_class.new([failed.new, successful.new, successful.new])
  end

  let(:failed) do
    Class.new do
      def ok?
        false
      end

      def puts(io)
        io.puts('measurement info')
      end
    end
  end

  let(:successful) do
    Class.new do
      def ok?
        true
      end

      def puts(io)
        io.puts('measurement info')
      end
    end
  end

  describe 'with no arguments' do
    before do
      capture_stdout { set.puts }
    end

    it 'should output the summary' do
      expect(@output).to eql([
        'measurement info',
        'measurement info',
        'measurement info',
        "\nYARD-Coverage: 66.6%  Success: 2  Failed: 1  Total: 3\n"
      ].join("\n"))
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
      expect(@output).to eql([
        'measurement info',
        'measurement info',
        'measurement info',
        "\nYARD-Coverage: 66.6%  Success: 2  Failed: 1  Total: 3\n",
      ].join("\n"))
    end
  end
end
