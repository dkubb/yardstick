# encoding: utf-8

require 'spec_helper'
require 'yardstick/rake/measurement'

describe Yardstick::Rake::Measurement, '#yardstick_measure' do
  subject { described_class.new(:yardstick_measure, options).yardstick_measure }

  let(:config)        { double('config', :path => 'tmp', :output => report_writer) }
  let(:report_writer) { double('report writer')                              }
  let(:options)       { double('options')                                    }
  let(:measurements)  { double('measurements')                               }
  let(:io)            { double('io')                                         }

  it 'writes yardstick results' do
    allow(Yardstick::Config).to receive(:coerce).with(options) { config }
    allow(Yardstick).to receive(:measure).with(config) { measurements }
    allow(report_writer).to receive(:write).and_yield(io)
    expect(measurements).to receive(:puts).with(io)
    subject
  end
end
