require 'spec_helper'

describe Yardstick::Config, '#set_defaults' do
  subject { described_class.new(options) }

  context 'when without options' do
    let(:options) { {} }

    its(:threshold)                { should be_nil }
    its(:verbose?)                 { should be(true) }
    its(:path)                     { should eq('lib/**/*.rb') }
    its(:require_exact_threshold?) { should be(true) }

    it 'sets rules to empty hash' do
      subject.instance_variable_get(:@rules).should eq({})
    end
  end

  context 'when with options' do
    let(:options) { {
      :threshold => 15,
      :verbose => false,
      :path => 'tmp/*.rb',
      :require_exact_threshold => false
    } }

    its(:threshold)                { should be(15) }
    its(:verbose?)                 { should be(false) }
    its(:path)                     { should eq('tmp/*.rb') }
    its(:require_exact_threshold?) { should be(false) }
  end
end
