# encoding: utf-8

require 'spec_helper'

describe Yardstick::Rule, '.coerce' do
  subject { described_class.coerce(document, config) }

  let(:document) { double('document') }
  let(:config)   { double('config')   }
  let(:options)  { { enabled: false } }

  before do
    config.stub(:options).with(described_class) { options }
  end

  it { should be_a(described_class) }

  it { should_not be_enabled }

  its(:document) { should be(document) }
end
