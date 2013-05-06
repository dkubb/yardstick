require 'spec_helper'

describe Yardstick, '.measure' do
  let(:string) { mock('string') }

  context 'when no arguments' do
    subject { described_class.measure_string(string) }

    it 'delegates to Processor' do
      processor = mock('processor')
      Yardstick::Processor.stub(:new).with(instance_of(Yardstick::Config)) { processor }
      processor.should_receive(:process_string).with(string)

      subject
    end
  end

  context 'when custom config' do
    subject { described_class.measure_string(string, config) }

    let(:config) { mock('config') }

    it 'delegates to Processor' do
      processor = mock('processor')
      Yardstick::Processor.stub(:new).with(config) { processor }
      processor.should_receive(:process_string).with(string)

      subject
    end
  end
end
