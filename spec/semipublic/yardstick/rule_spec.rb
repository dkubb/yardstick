# encoding: utf-8

require 'spec_helper'

describe Yardstick::Rule do
  let(:object)      { described_class.new(description) { true } }
  let(:description) { 'test rule'                               }

  describe '#eql?' do
    subject { object.eql?(other) }

    describe 'when rules are equal' do
      let(:other) { described_class.new(description) { true } }

      it 'is true' do
        should be(true)
      end
    end

    describe 'when rules are not equal' do
      let(:other) { described_class.new('other rule') { true } }

      it 'is false' do
        should be(false)
      end
    end
  end

  describe '#hash' do
    subject { object.hash }

    it 'is the expected hash' do
      should == description.hash
    end
  end
end
