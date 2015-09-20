# encoding: utf-8

require 'spec_helper'

describe Yardstick::Config, '#path' do
  subject { described_class.new(options).path }

  context 'when default options' do
    let(:options) { {} }

    it { should eq('lib/**/*.rb') }
  end
end
