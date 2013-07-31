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
end
