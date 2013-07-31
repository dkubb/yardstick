require 'spec_helper'

describe Yardstick::OrderedSet, 'length' do
  subject { described_class.new(items).length }

  let(:items) { [double('item'), double('item')] }

  it { should be(2) }
end
