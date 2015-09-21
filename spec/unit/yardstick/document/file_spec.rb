# encoding: utf-8

require 'spec_helper'

describe Yardstick::Document, '#file' do
  subject { described_class.new(docstring).file }

  let(:docstring) { double('docstring', object: object)   }
  let(:object)    { double('object', file: '/foo/bar.rb') }

  it { should be_kind_of(Pathname) }

  its(:to_s) { should eql('/foo/bar.rb') }
end
