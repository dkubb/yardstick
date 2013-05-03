require 'spec_helper'

describe Yardstick::Rules::ApiTag::ProtectedMethod, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { mock('document') }

  context 'when with protected api tag' do
    before { document.stub(:api?).with(%w[ semipublic private ]).and_return(true) }

    it { should be(true) }
  end

  context 'when not protected visibility' do
    before { document.stub(:api?).with(%w[ semipublic private ]).and_return(false) }

    it { should be(false) }
  end
end
