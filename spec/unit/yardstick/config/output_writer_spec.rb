require 'spec_helper'

describe Yardstick::Config, '#output=' do
  subject { config.output = output }

  let(:config) { described_class.new }
  let(:path)   { 'tmp/*.rb'          }

  before { config.output = path }

  context 'output' do
    subject { config.output }

    it { should be_a(Yardstick::ReportOutput) }

    its(:to_s) { should == 'tmp/*.rb' }
  end
end
