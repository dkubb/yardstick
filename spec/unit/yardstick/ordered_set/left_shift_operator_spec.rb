# encoding: utf-8

require 'spec_helper'

describe Yardstick::OrderedSet, '#<<' do
  subject { set << item }

  let(:set)  { described_class.new }
  let(:item) { double('item')      }

  it { should be(set) }

  it { should include(item) }

  its(:length) { should be(1) }

  context 'when operation is repeated' do
    it do
      expect { set << item << item }.to change(set, :to_a).from([]).to([item])
    end
  end
end
