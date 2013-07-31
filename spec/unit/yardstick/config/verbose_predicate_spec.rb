require 'spec_helper'

describe Yardstick::Config, '#verbose?' do
  subject { described_class.new(config).verbose? }

  context 'when set to true' do
    let(:config) { { verbose: true } }

    it { should be(true) }
  end

  context 'when set to false' do
    let(:config) { { verbose: false } }

    it { should be(false) }
  end
end
