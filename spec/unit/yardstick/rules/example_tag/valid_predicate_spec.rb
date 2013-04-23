require 'spec_helper'

describe Yardstick::Rules::ExampleTag, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { mock('document') }

  context 'with example tag' do
    before { document.stub(:has_tag?).with('example').and_return(true) }
    it { should be(true) }
  end

  context 'without example tag' do
    before { document.stub(:has_tag?).with('example').and_return(false) }

    it { should be(false) }
  end
end
