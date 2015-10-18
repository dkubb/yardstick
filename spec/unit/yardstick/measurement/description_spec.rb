# encoding: utf-8

require 'spec_helper'

describe Yardstick::Measurement, '#description' do
  subject { described_class.new(rule).description }

  let(:rule)     { ValidRule.new(document) }
  let(:document) { DocumentMock.new        }

  let(:formatted_description) do
    Yardstick::RuleDescription::Formatter.new(ValidRule.description).format
  end

  it { should eql(ValidRule.description) }
end
