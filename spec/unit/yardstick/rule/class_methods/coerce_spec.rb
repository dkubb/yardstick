require 'spec_helper'

describe Yardstick::Rule, '.coerce' do
  subject { described_class.coerce(document, config) }

  let(:document)    { DocumentMock.new }
  let(:config)      { mock('config')   }
  let(:rule_config) { Yardstick::RuleConfig.new(:enabled => false) }

  before do
    config.stub(:for_rule).with(described_class) { rule_config }
  end

  it { should be_a(described_class) }

  it { should_not be_enabled }
  its(:document) { should be(document) }
end
