# encoding: utf-8

require 'spec_helper'

describe Yardstick::Parser, '.parse_paths' do
  subject(:document_set) { described_class.parse_paths(paths) }

  let(:paths)         { double('paths')                                       }
  let(:method_object) { double(:file => 'foo.rb', :line => 4, :docstring => docstring) }
  let(:docstring)     { double('docstring')                                   }

  before do
    YARD.should_receive(:parse).with(paths, [], YARD::Logger::ERROR)
    YARD::Registry.stub(:all).with(:method).and_return([method_object])
  end

  it { should be_a(Yardstick::DocumentSet) }

  its(:length) { should be(1) }

  context 'first document' do
    subject { document_set.first }

    it { should be_a(Yardstick::Document) }

    its(:docstring) { should eq(docstring) }
  end
end
