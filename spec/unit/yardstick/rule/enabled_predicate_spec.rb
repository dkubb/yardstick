require 'spec_helper'

describe Yardstick::Rule, '#enabled?' do
  subject { described_class.new(document, options).enabled? }

  let(:document) { mock('document', :path => 'Foo#bar') }
  let(:options)  { {}                                }

  context 'when no options' do
    it { should be(true) }
  end

  context 'when disabled' do
    before { options[:enabled] = false }

    it { should be(false) }
  end

  context 'when current method is excluded' do
    before { options[:exclude] = ['Foo#bar'] }

    it { should be(false) }
  end
end
