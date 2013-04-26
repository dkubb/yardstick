require 'spec_helper'

describe Yardstick::Config, '.normalize_hash' do
  subject { described_class.normalize_hash(hash) }

  let(:hash) { {'foo' => {'bar' => 'baz'}} }

  it { should == {:foo => {:bar => 'baz'}} }
end
