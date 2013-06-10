require 'spec_helper'

describe Yardstick::Rule, '#validatable?' do
  subject { described_class.new(document).validatable? }

  let(:document) { mock('document') }

  it { should be(true) }
end
