require 'spec_helper'

describe Yardstick::ReportOutput, '#to_s' do
  subject { described_class.new(pathname).to_s }

  let(:pathname) { Pathname(path) }
  let(:path)     { '/foo/bar'     }

  it { should == path }
end
