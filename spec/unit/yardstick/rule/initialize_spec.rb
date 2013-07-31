require 'spec_helper'

describe Yardstick::Rule, '#initialize' do
  let(:document) { DocumentMock.new }

  context 'when options are not given' do
    subject { described_class.new(document) }

    it { should be_a(described_class) }

    it { should be_enabled }

    it 'does not exclude anything' do
      # I don't think this is a good test. Had to test it to get mutant
      # passing. Mutant mutates [] into [nil].
      expect(subject.instance_variable_get(:@exclude)).to eq([])
    end
  end

  context 'when options are given' do
    subject { described_class.new(document, options) }

    let(:options)  { { enabled: false } }

    it { should be_a(described_class) }

    it { should_not be_enabled }
  end
end
