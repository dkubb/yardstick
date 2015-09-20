# encoding: utf-8

require 'spec_helper'

describe Yardstick::Document, '#has_tag?' do
  subject { described_class.new(docstring).has_tag?(name) }

  let(:docstring) { double('docstring') }
  let(:name)      { 'tag name'          }

  it 'delegates to docstring' do
    expect(docstring).to receive(:has_tag?).with(name)
    subject
  end
end
