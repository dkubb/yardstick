# encoding: utf-8

require 'spec_helper'

describe Yardstick::RuleConfig, '#initialize' do
  context 'when no options given' do
    subject { described_class.new }

    it 'does not apply restrictions' do
      expect(subject.enabled_for_path?('Foo#bar')).to be(true)

      # Satisfy mutant
      expect(subject.instance_variable_get(:@exclude)).to eq([])
    end
  end
end
