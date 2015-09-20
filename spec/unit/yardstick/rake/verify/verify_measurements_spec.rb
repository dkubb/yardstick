# encoding: utf-8

require 'spec_helper'
require 'yardstick/rake/verify'

describe Yardstick::Rake::Verify, '#verify_measurements' do
  subject(:measure) do
    capture_stdout { described_class.new(:verify, options).verify_measurements }
  end

  let(:config)  { Yardstick::Config.new(:threshold => 90) }
  let(:options) { double('options')                    }

  before do
    allow(Yardstick::Config).to receive(:coerce).with(options) { config }
    allow(Yardstick).to receive(:measure).with(config) { measurements }
  end

  context 'when verbose' do
    let(:measurements) { double('measurements', :coverage => 0.9) }

    it 'outputs coverage' do
      measure
      expect(@output).to eq("YARD-Coverage: 90.0% (threshold: 90%)\n")
    end
  end

  context 'when not verbose' do
    let(:measurements) { double('measurements', :coverage => 0.9) }

    before do
      config.verbose = false
    end

    it 'outputs nothing' do
      measure
      expect(@output).to eq('')
    end
  end

  context 'when lower coverage' do
    let(:measurements) { double('measurements', :coverage => 0.434) }

    it 'outputs coverage' do
      expect { measure }.to raise_error(RuntimeError)
      expect(@output).to eq("YARD-Coverage: 43.4% (threshold: 90%)\n")
    end

    it 'raises error about low coverage' do
      expect { measure }
        .to raise_error(RuntimeError, 'YARD-Coverage must be at least 90% but was 43.4%')
    end
  end

  context 'when higher coverage' do
    let(:measurements) { double('measurements', :coverage => 0.9989) }

    it 'outputs coverage' do
      expect { measure }.to raise_error(RuntimeError)
      expect(@output).to eq("YARD-Coverage: 99.8% (threshold: 90%)\n")
    end

    it 'raises error about high coverage' do
      expect { measure }
        .to raise_error(RuntimeError, 'YARD-Coverage has increased above the threshold of 90% to 99.8%. You should update your threshold value.')
    end
  end

  context 'when higher coverage without exact threshold requirement' do
    let(:measurements) { double('measurements', :coverage => 1) }

    before do
      config.require_exact_threshold = false
    end

    it 'outputs coverage' do
      measure
      expect(@output).to eq("YARD-Coverage: 100.0% (threshold: 90%)\n")
    end

    it 'passes' do
      expect { measure }.to_not raise_error
    end
  end
end
