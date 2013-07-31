require 'spec_helper'

describe Yardstick::OrderedSet, '#index' do
  subject { set.index(item) }

  let(:item) { double('item') }

  context 'when provided an included item' do
    let(:set) { described_class.new([item]) }

    it { should be(0) }
  end

  context 'when provided an excluded item' do
    let(:set) { described_class.new }

    it { should be_nil }
  end
end
