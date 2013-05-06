require 'spec_helper'

describe Yardstick::Processor, '#process_string' do
  subject { described_class.new(config).process_string(string) }

  let(:config)    { mock('config') }
  let(:string)    { mock('string') }
  let(:documents) { mock('document set') }

  it 'measures specified string' do
    Yardstick::Parser.should_receive(:parse_string).with(string) { documents }
    documents.should_receive(:measure).with(config)
    subject
  end
end
