require 'spec_helper'

describe Yardstick::Config, '#output' do
  subject { described_class.new(options).output }

  context 'when default options' do
    let(:options) { {} }

    it { should be_instance_of(Pathname) }

    its(:to_s) { should == 'measurements/report.txt' }
  end
end
