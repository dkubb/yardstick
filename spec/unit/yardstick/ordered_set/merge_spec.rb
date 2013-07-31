require 'spec_helper'

describe Yardstick::OrderedSet, '#merge' do
  subject { set.merge(other) }

  let(:set)   { described_class.new([item1]) }
  let(:other) { described_class.new([item2]) }
  let(:item1) { double('item')               }
  let(:item2) { double('item')               }

  it { should be(set) }

  it { should include(item1, item2) }
end
