require 'spec_helper'

describe Yardstick::Document, '#tag_text' do
  subject { described_class.new(docstring).tag_text(name) }

  let(:name)      { 'api'                    }
  let(:docstring) { mock('docstring')        }
  let(:yard_tag)  { mock(:text => 'private') }

  before do
    docstring.stub(:tag).with(name) { yard_tag }
  end

  it { should eq('private') }
end
