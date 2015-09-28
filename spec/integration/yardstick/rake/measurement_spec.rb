# encoding: utf-8

require 'spec_helper'
require 'yardstick/rake/measurement'

describe Yardstick::Rake::Measurement do
  let(:file)   { Tempfile.new('report.txt') }
  let(:output) { Pathname(file.path)        }

  before do
    described_class.new do |config|
      config.path   = 'lib/yardstick.rb'
      config.output = output.to_s
    end
  end

  after { file.close }

  it 'writes the report' do
    Rake::Task['yardstick_measure'].execute
    expect(output.read)
      .to eql("\nYARD-Coverage: 100.0%  Success: 30  Failed: 0  Total: 30\n")
  end
end
