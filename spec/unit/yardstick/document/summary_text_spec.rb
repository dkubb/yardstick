# encoding: utf-8

require 'spec_helper'

describe Yardstick::Document, '#summary_text' do
  subject { described_class.new(docstring).summary_text }

  context 'when with summary' do
    let(:docstring) do
      YARD::Docstring.new("This is a method summary\n\nThis is a method body")
    end

    it { should eql('This is a method summary') }
    it { should be_an_instance_of(String) }
  end

  context 'when without summary' do
    let(:docstring) do
      "\n\nThis is a method body"
    end

    it { should eql('') }
  end

  context 'when empty' do
    let(:docstring) { '' }

    it { should eql('') }
  end
end
