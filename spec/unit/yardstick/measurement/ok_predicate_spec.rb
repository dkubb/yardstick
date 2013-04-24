require 'spec_helper'

describe Yardstick::Measurement, 'ok?' do
  subject { described_class.new(document, rule_class).ok? }

  let(:document) { DocumentMock.new }

  context 'when rule is valid' do
    let(:rule_class) { ValidRule }

    it { should be(true) }
  end

  context 'when rule is not valid' do
    let(:rule_class) { InvalidRule }

    it { should be(false) }
  end
end
