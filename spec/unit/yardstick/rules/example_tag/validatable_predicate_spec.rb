require 'spec_helper'

describe Yardstick::Rules::ExampleTag, '#validatable?' do
  subject { described_class.new(document).validatable? }

  let(:document) { mock('document') }

  before do
    document.stub(:api?).with(['private']) { false }
    document.stub(:tag_types).with('return') { ['Object'] }
  end

  it { should be(true) }

  context 'with private api' do
    before { document.stub(:api?).with(['private']).and_return(true) }

    it { should be(false) }
  end

  context 'with undefined return' do
    before { document.stub(:tag_types).with('return').and_return(['undefined']) }

    it { should be(false) }
  end
end
