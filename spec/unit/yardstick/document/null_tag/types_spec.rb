require 'spec_helper'

describe Yardstick::Document::NullTag, '#types' do
  subject { described_class.new.types }

  it { should eq([]) }
end
