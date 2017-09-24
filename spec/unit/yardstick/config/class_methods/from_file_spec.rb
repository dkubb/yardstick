# encoding: utf-8

require 'spec_helper'

describe Yardstick::Config, '.from_file' do
  subject(:config) { described_class.from_file(filename) }
  let(:filename) { 'spec/fixtures/config1.yml' }

  it 'loads configuration from the file' do
    expect(config.threshold).to eq 75.5

    # rules:
    #   ApiTag::Presence:
    #     enabled: true
    #     exclude: ["spec/foo/bar.rb"]
    rule = config.for_rule('Yardstick::Rules::ApiTag::Presence')
    expect(rule.enabled_for_path?('lib/foo/bar.rb')).to be true
    expect(rule.enabled_for_path?('spec/foo/bar.rb')).to be false
  end

  context  'when file does not exist' do
    let(:filename) { 'spec/fixtures/does-not-exist.yml' }

    it 'raises a File::NOENT exception' do
      expect { config }.to raise_error(Errno::ENOENT)
    end
  end

  context 'when overrides are specified' do
    subject(:config) { described_class.from_file(filename, overrides) }
    let(:overrides) { { "threshold" => 12.3 } }

    it 'overrides values specified in the config file' do
      expect(config.threshold).to eq 12.3
    end
  end

  context 'when block provided' do
    subject(:config) do
      described_class.from_file(filename) do |config|
        config.threshold = 33.3
      end
    end

    it 'overrides values specified in the config file' do
      expect(config.threshold).to eq 33.3
    end
  end
end
