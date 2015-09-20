# encoding: utf-8

require 'spec_helper'

describe Yardstick, '.measure' do
  context 'when no arguments' do
    subject { described_class.measure }

    it 'delegates to Processor' do
      processor = double('processor')
      allow(Yardstick::Processor).to receive(:new).with(instance_of(Yardstick::Config)) do
        processor
      end
      expect(processor).to receive(:process)
      subject
    end
  end

  context 'when custom config' do
    subject { described_class.measure(config) }

    let(:config) { double('config') }

    it 'delegates to Processor' do
      processor = double('processor')
      allow(Yardstick::Processor).to receive(:new).with(config) { processor }
      expect(processor).to receive(:process)
      subject
    end
  end
end
