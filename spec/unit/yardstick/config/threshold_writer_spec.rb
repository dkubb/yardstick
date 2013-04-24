require 'spec_helper'

describe Yardstick::Config, '#threshold=' do
  subject { described_class.new }

  let(:new_threshold) { 34 }

  before do
    subject.threshold = new_threshold
  end

  its(:threshold) { should be(new_threshold) }
end
