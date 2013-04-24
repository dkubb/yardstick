require 'spec_helper'

describe Yardstick::Measurement, '#initialize' do
  subject { described_class.new(DocumentMock.new, ValidRule) }

  it { should be_kind_of(described_class) }
end
