require 'spec_helper'

describe Yardstick::ReportOutput, '.coerce' do
  subject { described_class.coerce(target) }

  let(:target) { '/foo/bar.rb' }

  it { should be_a(described_class) }

  its(:to_s) { should eq(target) }

  it 'coerces target to Pathname' do
    target = subject.instance_variable_get(:@target)
    target.should be_a(Pathname)
  end
end
