require 'spec_helper'

describe Yardstick::OrderedSet, '#<<' do
  subject { set << item }

  let(:set)  { described_class.new }
  let(:item) { double('item')      }

  it { should be(set) }

  it { should include(item) }

  its(:length) { should be(1) }
end
