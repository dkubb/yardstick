# encoding: utf-8

require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

require 'yardstick'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  clear_tasks = proc { Rake::Task.clear }

  config.before(:all, &clear_tasks)
  config.before(      &clear_tasks)

  clear_yard_registry = proc { YARD::Registry.clear }

  config.before(:all, &clear_yard_registry)
  config.before(      &clear_yard_registry)

  def capture_stdout
    $stdout = StringIO.new
    yield
  ensure
    $stdout.rewind
    @output = $stdout.read
    $stdout = STDOUT
  end
end

shared_examples_for 'measured itself' do
  it 'should return a MeasurementSet' do
    @measurements.should be_kind_of(Yardstick::MeasurementSet)
  end

  it 'should be non-empty' do
    @measurements.should_not be_empty
  end

  it 'should all be correct' do
    @measurements.each { |measurement| measurement.should be_ok }
  end
end
