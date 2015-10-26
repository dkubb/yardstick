# encoding: utf-8

require 'spec_helper'

describe Yardstick::Rule, '.describe' do
  subject { subclass.description }

  let(:subclass) do
    Class.new(described_class) { describe 'markup' }
  end

  after do
    Yardstick::Document.registered_rules.delete(subclass)
  end

  it { should be_a(Yardstick::RuleDescription) }
end
