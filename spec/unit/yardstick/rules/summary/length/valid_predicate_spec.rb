# encoding: utf-8

require 'spec_helper'

describe Yardstick::Rules::Summary::Length, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { double('document', summary_text: text) }

  context 'with short summary' do
    let(:text) { 'A summary' }

    it { should be(true) }
  end

  context 'with short summary that includes umlauts' do
    let(:text) { 'ö' * 79 }

    it { should be(true) }
  end

  context 'with too long summary' do
    let(:text) { 'a' * 81 }

    it { should be(false) }
  end
end
