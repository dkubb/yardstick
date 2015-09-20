# encoding: utf-8

require 'spec_helper'

describe Yardstick::Processor, '#process_string' do
  subject { described_class.new(config).process_string(string) }

  let(:config)    { double('config')       }
  let(:string)    { double('string')       }
  let(:documents) { double('document set') }

  it 'measures specified string' do
    expect(Yardstick::Parser).to receive(:parse_string).with(string) { documents }
    expect(documents).to receive(:measure).with(config)
    subject
  end
end
