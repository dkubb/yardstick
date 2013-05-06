require 'spec_helper'

describe Yardstick::Processor, '#process' do
  subject { described_class.new(config).process }

  let(:config)    { mock('config', :path => path) }
  let(:path)      { mock('path', :to_s => 'foo/bar.rb') }
  let(:documents) { mock('document set') }

  it 'measures files specified in the config' do
    Yardstick::Parser.should_receive(:parse_paths).with(['foo/bar.rb']) { documents }
    documents.should_receive(:measure).with(config)
    subject
  end
end
