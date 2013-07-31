require 'spec_helper'

describe Yardstick::Document, '#visibility' do
  subject { described_class.new(docstring).visibility }

  let(:docstring) { double('docstring', object: object)      }
  let(:object)    { double('object', visibility: visibility) }

  context 'when true' do
    let(:visibility) { true }

    it { should be(true) }
  end

  context 'when false' do
    let(:visibility) { false }

    it { should be(false) }
  end
end
