require 'spec_helper'

describe Yardstick::Rules::ApiTag::ProtectedMethod, '#validatable?' do
  subject { described_class.new(document).validatable? }

  let(:document) { double('document', visibility: visibility) }

  context 'when protected visibility' do
    let(:visibility) { :protected }

    it { should be(true) }
  end

  context 'when not protected visibility' do
    let(:visibility) { :something }

    it { should be(false) }
  end
end
