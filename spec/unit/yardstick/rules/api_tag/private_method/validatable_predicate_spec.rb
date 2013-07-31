require 'spec_helper'

describe Yardstick::Rules::ApiTag::PrivateMethod, '#validatable?' do
  subject { described_class.new(document).validatable? }

  let(:document) { double('document', visibility: visibility) }

  context 'when protected visibility' do
    let(:visibility) { :private }

    it { should be(true) }
  end

  context 'when not protected visibility' do
    let(:visibility) { :something }

    it { should be(false) }
  end
end
