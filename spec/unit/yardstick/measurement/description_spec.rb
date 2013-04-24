require 'spec_helper'

describe Yardstick::Measurement, '#description' do
  subject { described_class.new(DocumentMock.new, ValidRule).description }

  it { should == ValidRule.description }
end
