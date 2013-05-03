# encoding: utf-8

require 'spec_helper'
require 'yardstick/rake/verify'

shared_examples_for 'set default name for verify task' do
  it 'should set name to :verify_measurements' do
    @task.instance_variable_get(:@name).should == :verify_measurements
  end
end

shared_examples_for 'set default require_exact_threshold for verify task' do
  it 'should set require_exact_threshold to true' do
    config = @task.instance_variable_get(:@config)
    config.require_exact_threshold?.should be_true
  end
end

shared_examples_for 'set default path for verify task' do
  path = 'lib/**/*.rb'

  it "should set path to #{path.inspect}" do
    config = @task.instance_variable_get(:@config)
    config.path.should == path
  end
end

shared_examples_for 'set default verbose for verify task' do
  it 'should set verbose to true' do
    config = @task.instance_variable_get(:@config)
    config.should be_verbose
  end
end

describe Yardstick::Rake::Verify do
  describe '.new' do
    describe 'with no arguments' do
      before do
        @task = Yardstick::Rake::Verify.new do |verify|
          verify.threshold = 100
        end
      end

      it 'should initialize a Verify instance' do
        @task.should be_kind_of(Yardstick::Rake::Verify)
      end

      it_should_behave_like 'set default name for verify task'
      it_should_behave_like 'set default require_exact_threshold for verify task'
      it_should_behave_like 'set default path for verify task'
      it_should_behave_like 'set default verbose for verify task'

      it 'should create a task named verify_measurements' do
        Rake::Task['verify_measurements'].should be_kind_of(Rake::Task)
      end

      it 'should include the threshold in the task name' do
        Rake.application.last_description.should == 'Verify that yardstick coverage is at least 100%'
      end

      it 'should display coverage summary when executed' do
        config = @task.instance_variable_get(:@config)
        config.path = 'lib/yardstick.rb'

        capture_stdout { Rake::Task['verify_measurements'].execute }

        @output.should == "YARD-Coverage: 100.0% (threshold: 100%)\n"
      end
    end

    describe 'with name provided' do
      before do
        @task = Yardstick::Rake::Verify.new({}, :custom_task_name) do |verify|
          verify.threshold = 100
        end
      end

      it 'should initialize a Verify instance' do
        @task.should be_kind_of(Yardstick::Rake::Verify)
      end

      it 'should set name to :custom_task_name' do
        @task.instance_variable_get(:@name).should == :custom_task_name
      end

      it_should_behave_like 'set default require_exact_threshold for verify task'
      it_should_behave_like 'set default path for verify task'
      it_should_behave_like 'set default verbose for verify task'

      it 'should create a task named custom_task_name' do
        Rake::Task['custom_task_name'].should be_kind_of(Rake::Task)
      end

      it 'should include the threshold in the task name' do
        Rake.application.last_description.should == 'Verify that yardstick coverage is at least 100%'
      end

      it 'should display coverage summary when executed' do
        config = @task.instance_variable_get(:@config)
        config.path = 'lib/yardstick.rb'

        capture_stdout { Rake::Task['custom_task_name'].execute }

        @output.should == "YARD-Coverage: 100.0% (threshold: 100%)\n"
      end
    end

    describe 'with threshold not provided' do
      it 'should raise an exception' do
        lambda {
          Yardstick::Rake::Verify.new {}
        }.should raise_error(RuntimeError, 'threshold must be set')
      end
    end
  end

  describe '#verify_measurements' do
    describe 'with threshold met' do
      before do
        @task = Yardstick::Rake::Verify.new do |verify|
          verify.threshold = 100
          verify.path      = 'lib/yardstick.rb'
        end

        capture_stdout do
          @task.verify_measurements
        end
      end

      it 'should output coverage summary' do
        @output.should == "YARD-Coverage: 100.0% (threshold: 100%)\n"
      end
    end

    describe 'with threshold not met' do
      before do
        @task = Yardstick::Rake::Verify.new do |verify|
          verify.threshold = 101.0
          verify.path      = 'spec/spec_helper.rb'
        end
      end

      it 'should raise an exception' do
        lambda {
          capture_stdout do
            @task.verify_measurements
          end
        }.should raise_error(RuntimeError, 'YARD-Coverage must be at least 101.0% but was 100.0%')

        # check the stdout output
        @output.should == "YARD-Coverage: 100.0% (threshold: 101.0%)\n"
      end
    end

    describe 'with threshold met, but not equal to coverage' do
      before do
        @task = Yardstick::Rake::Verify.new do |verify|
          verify.threshold = 99.9
          verify.path      = 'lib/yardstick.rb'
        end
      end

      it 'should raise an exception' do
        lambda {
          capture_stdout do
            @task.verify_measurements
          end
        }.should raise_error(RuntimeError, 'YARD-Coverage has increased above the threshold of 99.9% to 100.0%. You should update your threshold value.')

        # check the stdout output
        @output.should == "YARD-Coverage: 100.0% (threshold: 99.9%)\n"
      end
    end
  end
end
