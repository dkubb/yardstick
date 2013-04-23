require 'spec_helper'

describe Yardstick::Rules::ApiTag::Inclusion, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { mock('document') }

  %w[public semipublic private].each do |method_visibility|
    context "with #{method_visibility} method" do
      before { document.stub(:tag_text).with('api').and_return(method_visibility) }

      it { should be(true) }
    end
  end

  context 'with unknown method visibility' do
    before { document.stub(:tag_text).with('api').and_return('unknown') }

    it { should be(false) }
  end
end
