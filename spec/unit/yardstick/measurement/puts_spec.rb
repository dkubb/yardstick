require 'spec_helper'

describe Yardstick::Measurement, '#puts' do
  let(:document) { DocumentMock.new }

  describe 'with no arguments' do
    subject { @output }

    before do
      capture_stdout { described_class.new(rule).puts }
    end

    describe 'when the measurement is successful' do
      let(:rule) { ValidRule.new(document) }

      it { should == '' }
    end

    describe 'when the measurement is skipped' do
      let(:rule) { NotValidatableRule.new(document) }

      it { should == '' }
    end

    describe 'when the measurement is not successful' do
      let(:rule) { InvalidRule.new(document) }

      it { should == "(stdin):2: Foo#bar: not successful\n" }
    end
  end

  describe 'with an object implementing #puts' do
    subject { io.read }

    let(:io) { StringIO.new }

    before do
      described_class.new(rule).puts(io)
      io.rewind
    end

    describe 'when the measurement is successful' do
      let(:rule) { ValidRule.new(document) }

      it { should == '' }
    end

    describe 'when the measurement is skipped' do
      let(:rule) { NotValidatableRule.new(document) }

      it { should == '' }
    end

    describe 'when the measurement is not successful' do
      let(:rule) { InvalidRule.new(document) }

      it { should == "(stdin):2: Foo#bar: not successful\n" }
    end
  end
end
