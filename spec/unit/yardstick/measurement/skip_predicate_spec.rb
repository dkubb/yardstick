require 'spec_helper'

describe Yardstick::Measurement, 'skip?' do
  subject { described_class.new(document, rule_class).skip? }

  let(:document) { DocumentMock.new }

  context 'when rule is enabled' do
    let(:rule_class) { ValidRule }

    it { should be(false) }
  end

  context 'when rule is not validatable' do
    let(:rule_class) { NotValidatableRule }

    it { should be(true) }
  end

  context 'when rule is disabled' do
    let(:rule_class) { DisabledRule }

    it { should be(true) }
  end
end
