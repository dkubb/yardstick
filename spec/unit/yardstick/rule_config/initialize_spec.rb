require 'spec_helper'

describe Yardstick::RuleConfig, '#initialize' do
  context 'when no options given' do
    subject { described_class.new }

    it 'does not apply restrictions' do
      subject.enabled_for_path?('Foo#bar').should be(true)

      # Satisfy mutant
      subject.instance_variable_get(:@exclude).should eq([])
    end
  end
end
