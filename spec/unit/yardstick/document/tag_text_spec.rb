# encoding: utf-8

require 'spec_helper'

describe Yardstick::Document, '#tag_text' do
  subject { described_class.new(docstring).tag_text(name) }

  let(:name)      { 'api'                   }
  let(:docstring) { double('docstring')     }
  let(:yard_tag)  { double(text: 'private') }

  before do
    docstring.stub(:tag).with(name) { yard_tag }
  end

  it { should eq('private') }
end
