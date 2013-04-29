require 'spec_helper'

describe Yardstick::Config, '.coerce' do
  subject { described_class.coerce(hash) }

  let(:hash) { {'rules' => {'foo' => 'bar'}} }

  it { should be_instance_of(described_class) }

  it 'coerces hash' do
    rules = subject.instance_variable_get(:@rules)
    rules.should == {:foo => 'bar'}
  end
end
