require 'spec_helper'

describe Yardstick::Document, '#file' do
  subject { described_class.new(docstring).file }

  let(:docstring) { mock('docstring', :object => object)   }
  let(:object)    { mock('object', :file => '/foo/bar.rb') }

  it { should be_kind_of(Pathname) }
  its(:to_s) { should == '/foo/bar.rb' }
end
