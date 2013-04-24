require 'spec_helper'

describe Yardstick::Config, '#verbose=' do
  subject { described_class.new }

  context 'when argument is true' do
    before { subject.verbose = true }

    its(:verbose) { should be(true) }
  end

  context 'when argument is false' do
    before { subject.verbose = false }

    its(:verbose) { should be(false) }
  end
end
