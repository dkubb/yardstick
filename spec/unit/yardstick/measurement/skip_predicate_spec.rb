# encoding: utf-8

require 'spec_helper'

describe Yardstick::Measurement, 'skip?' do
  subject { described_class.new(rule).skip? }

  let(:document) { DocumentMock.new }

  context 'when rule is enabled' do
    let(:rule) { ValidRule.new(document) }

    it { should be(false) }
  end

  context 'when rule is not validatable' do
    let(:rule) { NotValidatableRule.new(document) }

    it { should be(true) }
  end

  context 'when rule is disabled' do
    let(:rule) { DisabledRule.new(document) }

    it { should be(true) }
  end
end
