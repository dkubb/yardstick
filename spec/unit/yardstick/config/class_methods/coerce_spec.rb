# encoding: utf-8

require 'spec_helper'

describe Yardstick::Config, '.coerce' do
  let(:hash) { { 'rules' => { 'foo' => 'bar' } } }

  context 'when without block' do
    subject { described_class.coerce(hash) }

    it { should be_instance_of(described_class) }

    it 'coerces hash' do
      rules = subject.instance_variable_get(:@rules)
      expect(rules).to eql(foo: 'bar')
    end
  end

  context 'when block provided' do
    subject do
      described_class.coerce(hash) { |config| config.path = new_path }
    end

    let(:new_path) { 'custom' }

    it { should be_instance_of(described_class) }

    it 'executes block as config' do
      expect(subject.path).to eql(new_path)
    end
  end

  context 'when default config file exists' do
    subject(:config) { described_class.coerce(hash) }

    before do
      allow(described_class)
        .to receive(:default_config_file)
        .and_return(Pathname('spec/fixtures/config1.yml'))
    end

    it 'includes configuration from the config file' do
      expect(config.threshold).to eq 75.5
    end

    context 'when hash has conflicting keys with the config file' do
      let(:hash) { { 'threshold' => 84.4 } }

      it 'uses the value from the hash' do
        expect(config.threshold).to eq 84.4
      end
    end
  end
end
