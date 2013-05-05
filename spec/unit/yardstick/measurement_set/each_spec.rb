require 'spec_helper'

describe Yardstick::MeasurementSet, '#each' do
  subject { set.each {|*args| yielded << args} }

  let(:set)         { described_class.new([measurement]) }
  let(:measurement) { mock('measurement') }
  let(:yielded)     { [] }

  it { should be(set) }

  it 'should yield measurements' do
    subject
    yielded.should eql([ [ measurement ] ])
  end
end
