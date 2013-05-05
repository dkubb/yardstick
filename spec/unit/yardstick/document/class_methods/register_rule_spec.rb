require 'spec_helper'

describe Yardstick::Document, '.register_rule' do
  subject { described_class.register_rule(rule_class) }

  let(:rule_class)   { Class.new                                                 }
  let(:rule_classes) { described_class.instance_variable_get(:@registered_rules) }

  after do
    rule_classes.delete(rule_class)
  end

  it 'adds rule_class to registered_rules' do
    subject
    rule_classes.should include(rule_class)
  end
end
