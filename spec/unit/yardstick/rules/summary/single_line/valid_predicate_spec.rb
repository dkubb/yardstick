require 'spec_helper'

describe Yardstick::Rules::Summary::SingleLine, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { double('document', summary_text: text) }

  context 'with one line summary' do
    let(:text) { 'A summary' }

    it { should be(true) }
  end

  context 'with more than one line' do
    let(:text) { "A summary\nA summary" }

    it { should be(false) }
  end
end
