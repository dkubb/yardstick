require 'spec_helper'

describe Yardstick::Config, '#for_rule' do
  subject { described_class.new(options).for_rule(rule_class) }

  let(:options) do
    {:rules => {:"Summary::Presence" => {:enabled => false}}}
  end
  let(:rule_config) { mock('RuleConfig') }

  context 'when rule is present' do
    let(:rule_class) { Yardstick::Rules::Summary::Presence }

    before do
      Yardstick::RuleConfig.stub(:new).with({:enabled => false}) { rule_config }
    end

    it { should be(rule_config) }
  end

  context 'when config does not have given rule' do
    let(:rule_class) { Yardstick::Rules::Summary::Length }

    before do
      Yardstick::RuleConfig.stub(:new).with({}) { rule_config }
    end

    it { should be(rule_config) }
  end

  context 'when invalid rule given' do
    let(:rule_class) { Object }

    it 'raises InvalidRule error' do
      msg = 'every rule must begin with Yardstick::Rules::'

      expect {
        subject
      }.to raise_error(described_class::InvalidRule, msg)
    end
  end
end
