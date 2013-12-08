# encoding: utf-8


require 'spec_helper'

describe Yardstick::Config, '#for_rule' do
  subject { described_class.new(options).for_rule(rule_class) }

  let(:options) do
    { :rules => { 'Summary::Presence'.to_sym => { :enabled => false } } }
  end

  let(:rule_config) { double('RuleConfig') }

  context 'when rule is present' do
    let(:rule_class) { Yardstick::Rules::Summary::Presence }

    before do
      allow(Yardstick::RuleConfig).to receive(:new).with(:enabled => false)
        .and_return(rule_config)
    end

    it { should be(rule_config) }
  end

  context 'when config does not have given rule' do
    let(:rule_class) { Yardstick::Rules::Summary::Length }

    before do
      allow(Yardstick::RuleConfig).to receive(:new).with({})
        .and_return(rule_config)
    end

    it { should be(rule_config) }
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
