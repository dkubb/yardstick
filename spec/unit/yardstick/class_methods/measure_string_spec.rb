# encoding: utf-8

require 'spec_helper'

describe Yardstick, '.measure' do
  let(:string) { double('string') }

  context 'when no arguments' do
    subject { described_class.measure_string(string) }

    it 'delegates to Processor' do
      processor = double('processor')
      config = instance_of(Yardstick::Config)
      allow(Yardstick::Processor)
        .to receive(:new).with(config).and_return(processor)
      expect(processor).to receive(:process_string).with(string)
      subject
    end
  end

  context 'when custom config' do
    subject { described_class.measure_string(string, config) }

    let(:config) { double('config') }

    it 'delegates to Processor' do
      processor = double('processor')
      allow(Yardstick::Processor)
        .to receive(:new).with(config).and_return(processor)
      expect(processor).to receive(:process_string).with(string)
      subject
    end
  end
end
