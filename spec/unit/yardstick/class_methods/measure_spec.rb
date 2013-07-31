require 'spec_helper'

describe Yardstick, '.measure' do
  context 'when no arguments' do
    subject { described_class.measure }

    it 'delegates to Processor' do
      processor = double('processor')
      Yardstick::Processor.stub(:new).with(instance_of(Yardstick::Config)) do
        processor
      end
      processor.should_receive(:process)
      subject
    end
  end

  context 'when custom config' do
    subject { described_class.measure(config) }

    let(:config) { double('config') }

    it 'delegates to Processor' do
      processor = double('processor')
      Yardstick::Processor.stub(:new).with(config) { processor }
      processor.should_receive(:process)
      subject
    end
  end
end
