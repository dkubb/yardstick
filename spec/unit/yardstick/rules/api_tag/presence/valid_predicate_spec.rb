# encoding: utf-8

require 'spec_helper'

describe Yardstick::Rules::ApiTag::Presence, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { double('document') }

  context 'with api tag' do
    before do
      allow(document).to receive(:has_tag?).with('api').and_return(true)
    end

    it { should be(true) }
  end

  context 'without api tag' do
    before do
      allow(document).to receive(:has_tag?).with('api').and_return(false)
    end

    it { should be(false) }
  end
end
