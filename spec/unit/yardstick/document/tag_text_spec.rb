# encoding: utf-8

require 'spec_helper'

describe Yardstick::Document, '#tag_text' do
  subject { described_class.new(docstring).tag_text(name) }

  let(:name)      { 'api'                   }
  let(:docstring) { double('docstring')     }
  let(:yard_tag)  { double(:text => 'private') }

  before do
    allow(docstring).to receive(:tag).with(name).and_return(yard_tag)
  end

  it { should eql('private') }
end
