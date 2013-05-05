require 'spec_helper'

describe Yardstick::Document, '#tag_types' do
  subject { described_class.new(docstring).tag_types(name) }

  let(:name)      { 'tag name'                         }
  let(:docstring) { mock('docstring')                  }
  let(:yard_tag)  { mock(:types => ['type1', 'type2']) }

  before do
    docstring.stub(:tag).with(name) { yard_tag }
  end

  it { should eq(['type1', 'type2']) }
end
