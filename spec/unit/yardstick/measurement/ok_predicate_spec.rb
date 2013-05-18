require 'spec_helper'

describe Yardstick::Measurement, 'ok?' do
  subject { described_class.new(rule).ok? }

  let(:document) { DocumentMock.new }

  context 'when rule is valid' do
    let(:rule) { ValidRule.new(document) }

    it { should be(true) }
  end

  context 'when rule is not valid' do
    let(:rule) { InvalidRule.new(document) }

    it { should be(false) }
  end
end
