require 'spec_helper'

describe Yardstick::Config, '#initialize' do
  it { should be_instance_of(described_class) }

  context 'when block provided' do
    subject {
      described_class.new { |config| config.path = new_path }
    }

    let(:new_path) { 'custom' }

    it { should be_instance_of(described_class) }

    it 'executes block as config' do
      subject.path.should == new_path
    end
  end
end
