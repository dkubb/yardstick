# encoding: utf-8

require 'spec_helper'

describe Yardstick::Processor, '#process' do
  subject { described_class.new(config).process }

  let(:config)    { double('config', :path => path) }
  let(:path)      { Pathname('foo/bar.rb')       }
  let(:documents) { double('document set')       }

  it 'measures files specified in the config' do
    expect(Yardstick::Parser).to receive(:parse_paths).with(['foo/bar.rb']) { documents }
    expect(documents).to receive(:measure).with(config)
    subject
  end
end
