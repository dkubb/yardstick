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
require 'devtools/spec_helper'

RSpec.configure do |config|
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
