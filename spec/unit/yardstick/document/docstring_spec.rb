require 'spec_helper'

describe Yardstick::Document, '#docstring' do
  subject { described_class.new(docstring).docstring }

  let(:docstring) { double('docstring') }

  it { should be(docstring) }
end
