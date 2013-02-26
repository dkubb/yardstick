# encoding: utf-8

if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start do
    command_name     'spec:unit'
    add_filter       'config'
    add_filter       'spec'
    minimum_coverage 100
  end
end

require 'yardstick'
require 'spec'
require 'rspec/autorun' if RUBY_VERSION < '1.9'

# require spec support files and shared behavior
Dir[File.expand_path('../{support,shared}/**/*.rb', __FILE__)].each do |file|
  require file
end

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
