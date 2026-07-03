# frozen_string_literal: true

require 'spec_helper'

describe Yardstick, '.measure_string' do
  let(:string) { double('string') }

  context 'when no arguments' do
    subject { described_class.measure_string(string) }

    it 'delegates to Processor' do
      processor = double('processor')
      allow(Yardstick::Processor)
        .to receive(:new).with(config: instance_of(Yardstick::Config)).and_return(processor)
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
        .to receive(:new).with(config: config).and_return(processor)
      expect(processor).to receive(:process_string).with(string)
      subject
    end
  end
end
