require 'spec_helper'
require 'yardstick/rake/measurement'

describe Yardstick::Rake::Measurement, '#yardstick_measure' do
  subject { described_class.new(:yardstick_measure, options).yardstick_measure }

  let(:config)        { double('config', path: 'tmp', output: report_writer) }
  let(:report_writer) { double('report writer')                              }
  let(:options)       { double('options')                                    }
  let(:measurements)  { double('measurements')                               }
  let(:io)            { double('io')                                         }

  it 'writes yardstick results' do
    Yardstick::Config.stub(:coerce).with(options) { config }
    Yardstick.stub(:measure).with(config) { measurements }
    report_writer.stub(:write).and_yield(io)
    measurements.should_receive(:puts).with(io)
    subject
  end
end
