require 'spec_helper'

describe Yardstick::OrderedSet, '#each' do
  subject { set.each {|*args| yielded << args} }

  let(:set)     { described_class.new([item]) }
  let(:item)    { mock('item') }
  let(:yielded) { [] }

  it { should be(set) }

  it 'should yield items' do
    subject
    yielded.should eql([ [ item ] ])
  end
end
