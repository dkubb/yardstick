require 'spec_helper'

describe Yardstick::Rules::Summary::Presence, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { double('document', summary_text: text) }

  context 'with summary' do
    let(:text) { 'A summary' }

    it { should be(true) }
  end

  context 'without summary' do
    let(:text) { '' }

    it { should be(false) }
  end
end
