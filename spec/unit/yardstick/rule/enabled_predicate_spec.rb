require 'spec_helper'

describe Yardstick::Rule, '#enabled?' do
  subject { described_class.new(document, config).enabled? }

  let(:document)     { mock('document', :path => 'Foo#bar') }
  let(:config)       { mock('RuleConfig')                   }
  let(:return_value) { mock('Boolean')                      }

  before do
    config.stub(:enabled_for_path?).with('Foo#bar') { return_value }
  end

  it { should eq(return_value) }
end
