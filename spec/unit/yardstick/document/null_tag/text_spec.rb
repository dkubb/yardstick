require 'spec_helper'

describe Yardstick::Document::NullTag, '#text' do
  subject { described_class.new.text }

  it { should be_nil }
end
