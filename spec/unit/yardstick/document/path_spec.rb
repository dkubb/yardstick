require 'spec_helper'

describe Yardstick::Document, '#path' do
  subject { described_class.new(docstring).path }

  let(:docstring) { mock('docstring', :object => object) }
  let(:object)    { mock('object', :path => 'Foo#bar')   }

  it { should eq('Foo#bar') }
end
