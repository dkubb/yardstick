require 'spec_helper'

describe Yardstick::Rule, '#validatable?' do
  subject { described_class.new(document, options).validatable? }

  let(:document) { double('document') }
  let(:options)  { {}                 }

  it { should be(true) }
end
