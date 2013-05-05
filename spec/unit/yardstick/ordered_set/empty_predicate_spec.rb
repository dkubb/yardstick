require 'spec_helper'

describe Yardstick::OrderedSet, '#empty?' do
  subject { set.empty? }

  context 'when there are no items' do
    let(:set) { described_class.new }

    it { should be(true) }
  end

  context 'when there are items' do
    let(:set) { described_class.new([mock('item')]) }

    it { should be(false) }
  end
end
