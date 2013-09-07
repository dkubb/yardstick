# encoding: utf-8

require 'spec_helper'

describe Yardstick::ReportOutput, '#initialize' do
  subject { described_class.new(target) }

  let(:target) { Pathname('/foo/bar') }

  it { should be_instance_of(described_class) }
end
