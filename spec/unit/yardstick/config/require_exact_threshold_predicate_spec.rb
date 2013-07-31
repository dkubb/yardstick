require 'spec_helper'

describe Yardstick::Config, '#require_exact_threshold?' do
  subject { described_class.new(config).require_exact_threshold? }

  context 'when set to true' do
    let(:config) { { require_exact_threshold: true } }

    it { should be(true) }
  end

  context 'when set to false' do
    let(:config) { { require_exact_threshold: false } }

    it { should be(false) }
  end
end
