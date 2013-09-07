# encoding: utf-8

require 'spec_helper'

describe Yardstick::Document, '.measure' do
  subject { described_class.measure(document, config) }

  let(:config)    { Yardstick::Config.new }
  let(:document)  { double('document')    }

  let(:registered_rules) do
    described_class.instance_variable_get(:@registered_rules)
  end

  before do
    registered_rules.each do |rule_class|
      rule_class.should_receive(:coerce).with(document, config)
        .and_return(ValidRule.new(document))
    end
  end

  it { should be_a(Yardstick::MeasurementSet) }

  its(:first) { should be_a(Yardstick::Measurement) }
end
