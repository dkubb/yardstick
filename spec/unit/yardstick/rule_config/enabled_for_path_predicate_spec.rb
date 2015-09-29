# encoding: utf-8

require 'spec_helper'

describe Yardstick::RuleConfig, '#enabled_for_path?' do
  subject { instance.enabled_for_path?(path) }

  %w[Foo::Bar#baz Foo::Bar.baz].each do |method|
    let(:path) { method }

    context 'when no restrictions' do
      let(:instance) { described_class.new }

      it { should be(true) }
    end

    context 'when disabled' do
      let(:instance) { described_class.new(enabled: false) }

      it { should be(false) }
    end

    context 'when excluded by exact path' do
      let(:instance) { described_class.new(exclude: [path]) }

      it { should be(false) }
    end

    context 'when excluded by class or module' do
      let(:instance) { described_class.new(exclude: ['Foo::Bar']) }

      it { should be(false) }
    end

    context 'when excluded by superclass or subclass' do
      let(:instance) { described_class.new(exclude: ['Foo', 'Foo::Bar::Sub']) }

      it { should be(true) }
    end
  end
end
