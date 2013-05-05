# encoding: utf-8

require 'spec_helper'
require 'yardstick/rake/measurement'

shared_examples_for 'set default name for measurement task' do
  it 'should set name to :yardstick_measure' do
    @task.instance_variable_get(:@name).should == :yardstick_measure
  end
end

shared_examples_for 'report writer' do
  it 'should write the report' do
    execute_action
    @output.read.should == "\nYARD-Coverage: 100.0%  Success: 20  Failed: 0  Total: 20\n"
  end
end

describe Yardstick::Rake::Measurement do
  before do
    @output = Pathname('measurements/report.txt')
    @output.dirname.rmtree if @output.dirname.exist?
  end

  describe '.new' do
    describe 'with no arguments' do
      before do
        @task = Yardstick::Rake::Measurement.new { |config|
          config.path = 'lib/yardstick.rb'
        }
      end

      it 'should initialize a Measurement instance' do
        @task.should be_kind_of(Yardstick::Rake::Measurement)
      end

      it_should_behave_like 'set default name for measurement task'

      it 'should create a task named yardstick_measure' do
        Rake::Task['yardstick_measure'].should be_kind_of(Rake::Task)
      end

      it 'should include the path in the task name' do
        Rake.application.last_description.should == 'Measure docs in lib/yardstick.rb with yardstick'
      end

      def execute_action
        Rake::Task['yardstick_measure'].execute
      end

      it_should_behave_like 'report writer'
    end

    describe 'with name provided' do
      before do
        @task = Yardstick::Rake::Measurement.new(:custom_task_name, {:path => 'lib/yardstick.rb'})
      end

      it 'should initialize a Measurement instance' do
        @task.should be_kind_of(Yardstick::Rake::Measurement)
      end

      it 'should set name to :custom_task_name' do
        @task.instance_variable_get(:@name).should == :custom_task_name
      end

      it 'should create a task named custom_task_name' do
        Rake::Task['custom_task_name'].should be_kind_of(Rake::Task)
      end

      it 'should include the path in the task name' do
        Rake.application.last_description.should == 'Measure docs in lib/yardstick.rb with yardstick'
      end

      def execute_action
        Rake::Task['custom_task_name'].execute
      end

      it_should_behave_like 'report writer'
    end

    describe 'with block provided' do
      before do
        @task = Yardstick::Rake::Measurement.new do |config|
          config.path = 'lib/yardstick.rb'
          @yield = config
        end
      end

      it 'should initialize a Measurement instance' do
        @task.should be_kind_of(Yardstick::Rake::Measurement)
      end

      it_should_behave_like 'set default name for measurement task'

      it 'should yield to Config' do
        @yield.should be_instance_of(Yardstick::Config)
      end

      it 'should create a task named yardstick_measure' do
        Rake::Task['yardstick_measure'].should be_kind_of(Rake::Task)
      end

      it 'should include the path in the task name' do
        Rake.application.last_description.should == 'Measure docs in lib/yardstick.rb with yardstick'
      end

      def execute_action
        Rake::Task['yardstick_measure'].execute
      end

      it_should_behave_like 'report writer'
    end
  end

  describe '#yardstick_measure' do
    before do
      @task = Yardstick::Rake::Measurement.new do |config|
        config.path   = 'lib/yardstick.rb'
        config.output = @output
      end
    end

    def execute_action
      @task.yardstick_measure
    end

    it_should_behave_like 'report writer'
  end
end
