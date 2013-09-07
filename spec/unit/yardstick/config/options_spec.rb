# encoding: utf-8

require 'spec_helper'

describe Yardstick::Config, '#options' do
  subject { described_class.new(options).options(rule_class) }

  let(:options) do
    { rules: { 'Summary::Presence'.to_sym => { enabled: false } } }
  end

  context 'when rule is present' do
    let(:rule_class) { Yardstick::Rules::Summary::Presence }

    it { should eq(enabled: false) }
  end

  context 'when config does not have given rule' do
    let(:rule_class) { Yardstick::Rules::Summary::Length }

    it { should eq({}) }
  end

  context 'when invalid rule given' do
    let(:rule_class) { Object }

    it 'raises InvalidRule error' do
      msg = 'every rule must begin with Yardstick::Rules::'

      expect { subject }
        .to raise_error(described_class::InvalidRule, msg)
    end
  end
end
