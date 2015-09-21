# encoding: utf-8

require 'spec_helper'

describe Yardstick::Rule, '#enabled?' do
  subject { described_class.new(document, config).enabled? }

  let(:document)     { double('document', path: 'Foo#bar') }
  let(:config)       { double('RuleConfig')                }
  let(:return_value) { double('Boolean')                   }

  before do
    allow(config).to receive(:enabled_for_path?).with('Foo#bar')
      .and_return(return_value)
  end

  it { should eq(return_value) }
end
