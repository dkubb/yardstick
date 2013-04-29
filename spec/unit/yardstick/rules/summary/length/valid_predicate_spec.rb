require 'spec_helper'

describe Yardstick::Rules::Summary::Length, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { mock('document', :summary_text => text) }

  context 'with short summary' do
    let(:text) { 'A summary' }

    it { should be(true) }
  end

  context 'with too long summary' do
    let(:text) { 'a' * 81 }

    it { should be(false) }
  end
end
