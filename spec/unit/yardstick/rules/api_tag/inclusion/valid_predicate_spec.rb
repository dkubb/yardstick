# encoding: utf-8

require 'spec_helper'

describe Yardstick::Rules::ApiTag::Inclusion, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { double('document') }

  %w[public semipublic private].each do |method_visibility|
    context "with #{method_visibility} method" do
      before do
        document.stub(:tag_text).with('api').and_return(method_visibility)
      end

      it { should be(true) }
    end
  end

  context 'with unknown method visibility' do
    before do
      document.stub(:tag_text).with('api').and_return('unknown')
    end

    it { should be(false) }
  end
end
