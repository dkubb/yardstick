require 'spec_helper'

describe Yardstick::Config, '#verbose=' do
  subject { described_class.new }

  context 'when argument is true' do
    before { subject.verbose = true }

    it { should be_verbose }
  end

  context 'when argument is false' do
    before { subject.verbose = false }

    it { should_not be_verbose }
  end
end
