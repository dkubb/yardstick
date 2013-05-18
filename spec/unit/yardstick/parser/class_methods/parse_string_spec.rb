require 'spec_helper'

describe Yardstick::Parser, '.parse_string' do
  subject(:document_set) { described_class.parse_string(string) }

  let(:string)        { mock('string', :to_str => 'body') }
  let(:method_object) { mock(:file => 'foo.rb', :line => 4, :docstring => docstring) }
  let(:docstring)     { mock('docstring') }

  before do
    YARD.should_receive(:parse_string).with('body')
    YARD::Registry.stub(:all).
      with(:method).
      and_return([method_object])
  end

  it { should be_a(Yardstick::DocumentSet) }
  its(:length) { should be(1) }

  context 'first document' do
    subject { document_set.first }

    it { should be_a(Yardstick::Document) }
    its(:docstring) { should eq(docstring) }
  end
end
