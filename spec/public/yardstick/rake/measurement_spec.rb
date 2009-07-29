require 'pathname'
require Pathname(__FILE__).dirname.expand_path.join('..', '..', '..', 'spec_helper')

shared_examples_for 'set default name for measurement task' do
  it 'should set name to :yardstick_measure' do
    @task.instance_variable_get(:@name).should == :yardstick_measure
  end
end

shared_examples_for 'set default path for measurement task' do
  path = 'lib/**/*.rb'

  it "should set path to #{path.inspect}" do
    @task.instance_variable_get(:@path).should == path
  end
end

shared_examples_for 'set default output for measurement task' do
  it 'should set output to "measurements/report.txt"' do
    @task.instance_variable_get(:@output).should == @output
  end
end

shared_examples_for 'report writer' do
  it 'should write the report' do
    @task.path = 'lib/yardstick.rb'  # speed up execution
    execute_action
    @output.read.should == "\nCoverage: 100.0%  Success: 20  Failed: 0  Total: 20\n"
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
        @task = Yardstick::Rake::Measurement.new
      end

      it 'should initialize a Measurement instance' do
        @task.should be_kind_of(Yardstick::Rake::Measurement)
      end

      it_should_behave_like 'set default name for measurement task'
      it_should_behave_like 'set default path for measurement task'
      it_should_behave_like 'set default output for measurement task'

      it 'should create a task named yardstick_measure' do
        Rake::Task['yardstick_measure'].should be_kind_of(Rake::Task)
      end

      it 'should include the path in the task name' do
        Rake::Task['yardstick_measure'].comment.should == 'Measure docs in lib/**/*.rb with yardstick'
      end

      def execute_action
        Rake::Task['yardstick_measure'].execute
      end

      it_should_behave_like 'report writer'
    end

    describe 'with name provided' do
      before do
        @task = Yardstick::Rake::Measurement.new(:custom_task_name)
      end

      it 'should initialize a Measurement instance' do
        @task.should be_kind_of(Yardstick::Rake::Measurement)
      end

      it 'should set name to :custom_task_name' do
        @task.instance_variable_get(:@name).should == :custom_task_name
      end

      it_should_behave_like 'set default path for measurement task'
      it_should_behave_like 'set default output for measurement task'

      it 'should create a task named custom_task_name' do
        Rake::Task['custom_task_name'].should be_kind_of(Rake::Task)
      end

      it 'should include the path in the task name' do
        Rake::Task['custom_task_name'].comment.should == 'Measure docs in lib/**/*.rb with yardstick'
      end

      def execute_action
        Rake::Task['custom_task_name'].execute
      end

      it_should_behave_like 'report writer'
    end

    describe 'with block provided' do
      before do
        @task = Yardstick::Rake::Measurement.new do |*args|
          @yield = args
        end
      end

      it 'should initialize a Measurement instance' do
        @task.should be_kind_of(Yardstick::Rake::Measurement)
      end

      it_should_behave_like 'set default name for measurement task'
      it_should_behave_like 'set default path for measurement task'
      it_should_behave_like 'set default output for measurement task'

      it 'should yield to self' do
        @yield.should == [ @task ]
        @yield.first.should equal(@task)
      end

      it 'should create a task named yardstick_measure' do
        Rake::Task['yardstick_measure'].should be_kind_of(Rake::Task)
      end

      it 'should include the path in the task name' do
        Rake::Task['yardstick_measure'].comment.should == 'Measure docs in lib/**/*.rb with yardstick'
      end

      def execute_action
        Rake::Task['yardstick_measure'].execute
      end

      it_should_behave_like 'report writer'
    end
  end

  describe '#path=' do
    before do
      @path = 'lib/yardstick.rb'

      @task = Yardstick::Rake::Measurement.new do |measurement|
        measurement.path = @path
      end
    end

    it 'should set path' do
      @task.instance_variable_get(:@path).should equal(@path)
    end
  end

  describe '#output=' do
    before do
      @task = Yardstick::Rake::Measurement.new do |measurement|
        measurement.output = @output
      end
    end

    it 'should set output' do
      @task.instance_variable_get(:@output).should eql(@output)
    end
  end

  describe '#yardstick_measure' do
    before do
      @task = Yardstick::Rake::Measurement.new do |task|
        task.output = @output
      end
    end

    def execute_action
      @task.yardstick_measure
    end

    it_should_behave_like 'report writer'
  end
end
