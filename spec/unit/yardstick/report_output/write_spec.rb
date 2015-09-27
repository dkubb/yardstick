# encoding: utf-8

require 'spec_helper'

describe Yardstick::ReportOutput, '#write' do
  subject do
    described_class.new(target).write do |io|
      io.puts 'content'
    end
  end

  let(:target)  { double('Pathname', dirname: dirname) }
  let(:dirname) { double                               }

  before do
    allow(dirname).to receive(:mkpath)
    allow(target).to receive(:open)
  end

  it 'creates directory' do
    expect(dirname).to receive(:mkpath)
    subject
  end

  it 'writes content' do
    io = double
    expect(io).to receive(:puts).with('content')
    expect(target).to receive(:open).with('w').and_yield(io)
    subject
  end
end
