# encoding: utf-8

require 'spec_helper'

describe Yardstick::Rule, '#validatable?' do
  subject { described_class.new(document).validatable? }

  let(:document) { double('document') }

  it { should be(true) }
end
