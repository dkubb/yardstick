require 'spec_helper'
require 'yardstick/rake/verify'

describe Yardstick::Rake::Verify, '#verify_measurements' do
  subject(:measure) do
    capture_stdout { described_class.new(:verify, options).verify_measurements }
  end

  let(:config)  { Yardstick::Config.new(:threshold => 90) }
  let(:options) { mock('options') }

  before do
    Yardstick::Config.stub(:coerce).with(options) { config }
    Yardstick.stub(:measure).with(config) { measurements }
  end

  context 'when verbose' do
    let(:measurements) { mock('measurements', :coverage => 0.9) }

    it 'outputs coverage' do
      measure
      @output.should eq("YARD-Coverage: 90.0% (threshold: 90%)\n")
    end
  end

  context 'when not verbose' do
    let(:measurements) { mock('measurements', :coverage => 0.9) }
    before { config.verbose = false }

    it 'outputs nothing' do
      measure
      @output.should eq('')
    end
  end

  context 'when lower coverage' do
    let(:measurements) { mock('measurements', :coverage => 0.434) }

    it 'outputs coverage' do
      expect { measure }.to raise_error
      @output.should eq("YARD-Coverage: 43.4% (threshold: 90%)\n")
    end

    it 'raises error about low coverage' do
      expect {
        measure
      }.to raise_error(RuntimeError, 'YARD-Coverage must be at least 90% but was 43.4%')
    end
  end

  context 'when higher coverage' do
    let(:measurements) { mock('measurements', :coverage => 0.9989) }

    it 'outputs coverage' do
      expect { measure }.to raise_error
      @output.should eq("YARD-Coverage: 99.9% (threshold: 90%)\n")
    end

    it 'raises error about high coverage' do
      expect {
        measure
      }.to raise_error(RuntimeError, 'YARD-Coverage has increased above the threshold of 90% to 99.9%. You should update your threshold value.')
    end
  end

  context 'when higher coverage without exact threshold requirement' do
    let(:measurements) { mock('measurements', :coverage => 1) }
    before { config.require_exact_threshold = false }

    it 'outputs coverage' do
      measure
      @output.should eq("YARD-Coverage: 100.0% (threshold: 90%)\n")
    end

    it 'passes' do
      expect { measure }.to_not raise_error
    end
  end
end
