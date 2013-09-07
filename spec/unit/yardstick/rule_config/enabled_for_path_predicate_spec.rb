# encoding: utf-8

require 'spec_helper'

describe Yardstick::RuleConfig, '#enabled_for_path?' do
  subject { described_class.new(options).enabled_for_path?(path) }

  let(:options) { {} }

  %w[ Foo::Bar#baz Foo::Bar.baz ].each do |method|
    let(:path) { method }

    context 'when no restrictions' do
      it { should be(true) }
    end

    context 'when disabled' do
      before { options[:enabled] = false }

      it { should be(false) }
    end

    context 'when excluded by exact path' do
      before { options[:exclude] = [path] }

      it { should be(false) }
    end

    context 'when excluded by class or module' do
      before { options[:exclude] = ['Foo::Bar'] }

      it { should be(false) }
    end

    context 'when excluded by superclass or subclass' do
      before { options[:exclude] = ['Foo', 'Foo::Bar::Sub'] }

      it { should be(true) }
    end
  end
end
