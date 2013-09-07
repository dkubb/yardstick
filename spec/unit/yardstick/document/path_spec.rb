# encoding: utf-8

require 'spec_helper'

describe Yardstick::Document, '#path' do
  subject { described_class.new(docstring).path }

  let(:docstring) { double('docstring', object: object) }
  let(:object)    { double('object', path: 'Foo#bar')   }

  it { should eq('Foo#bar') }
end
