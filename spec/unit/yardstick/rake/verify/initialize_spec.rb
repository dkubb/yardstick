require 'spec_helper'
require 'yardstick/rake/verify'

describe Yardstick::Rake::Verify, '#initialize' do
  context 'with custom arguments' do
    subject(:task) { described_class.new(:verify, options) }

    let(:config)  { Yardstick::Config.new(:threshold => 90) }
    let(:options) { mock('options') }

    before do
      Yardstick::Config.stub(:coerce).with(options) { config }
    end

    context 'when valid options' do
      it { should be_a(described_class) }

      it 'creates rake task with given name' do
        subject
        Rake::Task['verify'].should be_kind_of(Rake::Task)
      end

      it 'calls verify_measurements when rake task is executed' do
        subject
        task.should_receive(:verify_measurements)
        Rake::Task['verify'].execute
      end

      it 'should include the threshold in the task name' do
        task
        Rake.application.last_description.should == 'Verify that yardstick coverage is at least 90%'
      end
    end

    context 'when threshold is not specified' do
      before { config.threshold = nil }

      it 'raises error' do
        expect { task }.to raise_error(RuntimeError, 'threshold must be set')
      end
    end
  end

  context 'when with default arguments' do
    subject { described_class.new }

    it { should be_a(described_class) }

    it 'assigns verify_measurements as the name' do
      subject
      Rake::Task['verify_measurements'].should be_kind_of(Rake::Task)
    end
  end

  context 'when block provided' do
    subject(:task) do
      described_class.new do |config|
        @yield = config
      end
    end

    it { should be_a(described_class) }

    it 'should yield to Config' do
      task
      @yield.should be_instance_of(Yardstick::Config)
    end
  end
end
