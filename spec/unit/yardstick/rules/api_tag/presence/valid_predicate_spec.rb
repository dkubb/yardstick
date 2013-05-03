require 'spec_helper'

describe Yardstick::Rules::ApiTag::Presence, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { mock('document') }

  context 'with api tag' do
    before { document.stub(:has_tag?).with('api').and_return(true) }
    it { should be(true) }
  end

  context 'without api tag' do
    before { document.stub(:has_tag?).with('api').and_return(false) }

    it { should be(false) }
  end
end
