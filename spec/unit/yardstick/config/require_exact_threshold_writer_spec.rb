require 'spec_helper'

describe Yardstick::Config, '#require_exact_threshold=' do
  subject { described_class.new }

  context 'when argument is true' do
    before { subject.require_exact_threshold = true }

    its(:require_exact_threshold?) { should be(true) }
  end

  context 'when argument is false' do
    before { subject.require_exact_threshold = false }

    its(:require_exact_threshold?) { should be(false) }
  end
end
