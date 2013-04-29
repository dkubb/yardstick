require 'spec_helper'

describe Yardstick::Measurement, '#initialize' do
  subject { described_class.new(document, rule) }

  let(:rule)     { ValidRule.new(document) }
  let(:document) { DocumentMock.new }

  it { should be_kind_of(described_class) }
end
