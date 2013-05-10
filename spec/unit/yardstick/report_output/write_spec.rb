require 'spec_helper'

describe Yardstick::ReportOutput, 'write' do
  subject do
    described_class.new(target).write do |io|
      io.puts 'content'
    end
  end

  let(:target) { mock('Pathname', :dirname => dirname) }
  let(:dirname) { mock }

  before do
    dirname.stub(:mkpath)
    target.stub(:open)
  end

  it 'should create directory' do
    dirname.should_receive(:mkpath)
    subject
  end

  it 'should write content' do
    io = stub
    io.should_receive(:puts).with('content')
    target.should_receive(:open).with('w').and_yield(io)
    subject
  end
end
