# encoding: utf-8

require 'spec_helper'

describe Yardstick::Config, '#set_defaults' do
  subject { described_class.new(options) }

  context 'when without options' do
    let(:options) { {} }

    its(:threshold) { should be(100) }

    its(:verbose?) { should be(true) }

    its(:path) { should eql('lib/**/*.rb') }

    its(:require_exact_threshold?) { should be(true) }

    it 'sets rules to empty hash' do
      expect(subject.instance_variable_get(:@rules)).to eql({})
    end
  end

  context 'when with options' do
    let(:options) do
      {
        threshold:               15,
        verbose:                 false,
        path:                    'tmp/*.rb',
        require_exact_threshold: false
      }
    end

    its(:threshold) { should be(15) }

    its(:verbose?) { should be(false) }

    its(:path) { should eql('tmp/*.rb') }

    its(:require_exact_threshold?) { should be(false) }
  end
end
