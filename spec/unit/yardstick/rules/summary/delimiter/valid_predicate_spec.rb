require 'spec_helper'

describe Yardstick::Rules::Summary::Delimiter, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { double('document', summary_text: text) }

  context 'without a dot' do
    let(:text) { 'A summary' }

    it { should be(true) }
  end

  context 'with a dot' do
    let(:text) { 'A summary.' }

    it { should be(false) }
  end
end
