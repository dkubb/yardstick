require 'spec_helper'

describe Yardstick::Rules::Summary::Presence, '#validatable?' do
  subject { described_class.new(document).validatable? }

  let(:document) { double('document') }

  context 'with @see tag' do
    before { document.stub(:has_tag?).with('see').and_return(true) }

    it { should be(false) }
  end

  context 'without @see tag' do
    before { document.stub(:has_tag?).with('see').and_return(false) }

    it { should be(true) }
  end
end
