require 'spec_helper'

describe Yardstick::Rules::ApiTag::ProtectedMethod, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { double('document') }

  context 'when with protected api tag' do
    before do
      document.stub(:api?).with(%w[ semipublic private ]).and_return(true)
    end

    it { should be(true) }
  end

  context 'when not protected visibility' do
    before do
      document.stub(:api?).with(%w[semipublic private]).and_return(false)
    end

    it { should be(false) }
  end
end
