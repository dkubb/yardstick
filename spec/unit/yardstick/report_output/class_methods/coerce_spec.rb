# frozen_string_literal: true

require 'spec_helper'

describe Yardstick::ReportOutput, '.coerce' do
  subject { described_class.coerce(target) }

  let(:target) { '/foo/bar.rb' }

  it { should be_a(described_class) }

  its(:to_s) { should eql(target) }

  it 'coerces target to Pathname' do
    expect(subject.target).to be_a(Pathname)
  end
end
