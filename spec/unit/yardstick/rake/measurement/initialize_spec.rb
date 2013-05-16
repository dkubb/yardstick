require 'spec_helper'
require 'yardstick/rake/measurement'

describe Yardstick::Rake::Measurement, '#initialize' do
  context 'with custom arguments' do
    subject(:task) { described_class.new(:measure, options) }

    let(:config)  { Yardstick::Config.new }
    let(:options) { mock('options') }

    before do
      Yardstick::Config.stub(:coerce).with(options) { config }
    end

    context 'when valid options' do
      it { should be_a(described_class) }

      it 'creates rake task with given name' do
        subject
        Rake::Task['measure'].should be_kind_of(Rake::Task)
      end

      it 'calls yardstick_measure when rake task is executed' do
        subject
        task.should_receive(:yardstick_measure)
        Rake::Task['measure'].execute
      end

      it 'should include the threshold in the task name' do
        task
        Rake.application.last_description.should == 'Measure docs in lib/**/*.rb with yardstick'
      end
    end
  end

  context 'when with default arguments' do
    subject { described_class.new }

    it { should be_a(described_class) }

    it 'assigns yardstick_measure as the name' do
      subject
      Rake::Task['yardstick_measure'].should be_kind_of(Rake::Task)
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
