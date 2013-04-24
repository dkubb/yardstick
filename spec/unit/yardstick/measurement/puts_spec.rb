require 'spec_helper'

describe Yardstick::Measurement, '#puts' do
  let(:document)   { DocumentMock.new }

  describe 'with no arguments' do
    subject { @output }

    before do
      capture_stdout { described_class.new(document, rule_class).puts }
    end

    describe 'when the measurement is successful' do
      let(:rule_class) { ValidRule }

      it { should == '' }
    end

    describe 'when the measurement is skipped' do
      let(:rule_class) { NotValidatableRule }

      it { should == '' }
    end

    describe 'when the measurement is not successful' do
      let(:rule_class) { InvalidRule }

      it { should == "(stdin):2: Foo#bar: not successful\n" }
    end
  end

  describe 'with an object implementing #puts' do
    subject { io.read }

    let(:io) { StringIO.new }

    before do
      described_class.new(document, rule_class).puts(io)
      io.rewind
    end

    describe 'when the measurement is successful' do
      let(:rule_class) { ValidRule }

      it { should == '' }
    end

    describe 'when the measurement is skipped' do
      let(:rule_class) { NotValidatableRule }

      it { should == '' }
    end

    describe 'when the measurement is not successful' do
      let(:rule_class) { InvalidRule }

      it { should == "(stdin):2: Foo#bar: not successful\n" }
    end
  end
end
