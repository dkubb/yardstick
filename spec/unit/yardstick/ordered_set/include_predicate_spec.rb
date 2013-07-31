require 'spec_helper'

describe Yardstick::OrderedSet, '#include?' do
  subject { set.include?(item) }

  let(:item) { double('item') }

  context 'when provided an included item' do
    let(:set) { described_class.new([item]) }

    it { should be(true) }
  end

  context 'when provided an excluded item' do
    let(:set) { described_class.new }

    it { should be(false) }
  end
end
