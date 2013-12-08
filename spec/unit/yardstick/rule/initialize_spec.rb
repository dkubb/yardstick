# encoding: utf-8

require 'spec_helper'

describe Yardstick::Rule, '#initialize' do
  let(:document) { DocumentMock.new }

  context 'when rule config not given' do
    subject { described_class.new(document) }

    it { should be_a(described_class) }

    it { should be_enabled }
  end

  context 'when rule config is given' do
    subject { described_class.new(document, config) }

    let(:config) { Yardstick::RuleConfig.new(:enabled => false) }

    it { should be_a(described_class) }

    it { should_not be_enabled }
  end
end
