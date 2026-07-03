# frozen_string_literal: true

require 'spec_helper'

describe Yardstick::OrderedSet, '#each' do
  subject { set.each { |*args| yielded << args } }

  let(:set)     { described_class.new([item]) }
  let(:item)    { double('item')              }
  let(:yielded) { []                          }

  it { should be(set) }

  it 'yields items' do
    subject
    expect(yielded).to eql([[item]])
  end
end
