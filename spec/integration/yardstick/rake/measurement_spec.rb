require 'spec_helper'
require 'yardstick/rake/measurement'

describe Yardstick::Rake::Measurement do
  let(:output) { Pathname('measurements/report.txt') }

  before do
    output.dirname.rmtree if output.dirname.exist?

    Yardstick::Rake::Measurement.new do |config|
      config.path = 'lib/yardstick.rb'
    end
  end

  it 'should write the report' do
    Rake::Task['yardstick_measure'].execute
    output.read.should == "\nYARD-Coverage: 100.0%  Success: 20  Failed: 0  Total: 20\n"
  end
end
