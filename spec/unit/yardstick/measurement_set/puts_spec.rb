# encoding: utf-8

require 'spec_helper'

describe Yardstick::MeasurementSet, '#puts' do
  let(:set)      { described_class.new([failed, successful]) }
  let(:document) { DocumentMock.new                          }

  let(:failed) do
    Class.new do
      def ok?
        false
      end

      def puts(io)
        io.puts('measurement info')
      end
    end.new
  end

  let(:successful) do
    Class.new do
      def ok?
        true
      end

      def puts(io)
        io.puts('measurement info')
      end
    end.new
  end

  describe 'with no arguments' do
    before do
      capture_stdout { set.puts }
    end

    it 'should output the summary' do
      expect(@output).to eql([
        'measurement info',
        'measurement info',
        "\nYARD-Coverage: 50.0%  Success: 1  Failed: 1  Total: 2\n"
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
        "\nYARD-Coverage: 50.0%  Success: 1  Failed: 1  Total: 2\n",
      ].join("\n"))
    end
  end
end
