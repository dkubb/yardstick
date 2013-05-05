require 'spec_helper'

describe Yardstick::Document, '.measure' do
  subject { described_class.measure(docstring, config) }

  let(:docstring) { mock('docstring')     }
  let(:config)    { Yardstick::Config.new }
  let(:document)  { mock('document')      }

  let(:registered_rules) {
    described_class.instance_variable_get(:@registered_rules)
  }

  before do
    described_class.stub(:new).with(docstring) { document }

    registered_rules.each do |rule_class|
      rule_class.should_receive(:prepare).
        with(document, config).
        and_return(ValidRule.new(document))
    end
  end

  it { should be_a(Yardstick::MeasurementSet) }

  its(:first) { should be_a(Yardstick::Measurement) }
end
