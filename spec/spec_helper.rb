# frozen_string_literal: true

if ENV['COVERAGE'] == 'true'
  require 'simplecov'

  SimpleCov.start do
    add_filter '/config'
    add_filter '/spec'
    add_filter '/vendor'
    minimum_coverage 100
  end
end

require 'tempfile'
require 'rspec/its'
require 'yardstick'

Dir[File.join(__dir__, 'support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expect_with|
    expect_with.syntax = :expect
  end

  clear_tasks = proc { Rake::Task.clear }

  config.before(:all, &clear_tasks)
  config.before(&clear_tasks)

  clear_yard_registry = proc { YARD::Registry.clear }

  config.before(:all, &clear_yard_registry)
  config.before(&clear_yard_registry)

  def capture_stdout
    $stdout = StringIO.new
    yield
  ensure
    $stdout.rewind
    @output = $stdout.read
    $stdout = STDOUT
  end
end
