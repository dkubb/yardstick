# frozen_string_literal: true

require 'spec_helper'

describe Yardstick::Config, '#path' do
  subject { described_class.new(options).path }

  context 'when default options' do
    let(:options) { {} }

    it { should eql('lib/**/*.rb') }
  end
end
