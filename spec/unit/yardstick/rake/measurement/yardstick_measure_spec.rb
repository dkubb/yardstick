require 'spec_helper'
require 'yardstick/rake/measurement'

describe Yardstick::Rake::Measurement, '#yardstick_measure' do
  subject { described_class.new(:yardstick_measure, options).yardstick_measure }

  let(:config)        { mock('config', :path => 'tmp', :output => report_writer) }
  let(:report_writer) { mock('report writer') }
  let(:options)       { mock('options') }
  let(:measurements)  { mock('measurements') }
  let(:io)            { mock('io') }

  it 'writes yardstick results' do
    Yardstick::Config.stub(:coerce).with(options) { config }
    Yardstick.stub(:measure).with(config) { measurements }
    report_writer.stub(:write).and_yield(io)
    measurements.should_receive(:puts).with(io)

    subject
  end
end
