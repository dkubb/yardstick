# encoding: utf-8

require 'pathname'
require 'rational'

require 'backports'
require 'yard'

require 'yardstick/ordered_set'
require 'yardstick/rule_set'
require 'yardstick/measurement'

require 'yardstick/measurement_set'
require 'yardstick/processor'
require 'yardstick/rule'

require 'yardstick/measurable'
require 'yardstick/method'

require 'yardstick/yard_ext'

require 'yardstick/version'

# Fix jruby-head to use the ruby 1.8 parser until their ripper port is ready
if RUBY_VERSION == '1.9.3' && RUBY_ENGINE == 'jruby' && JRUBY_VERSION >= '1.7.4.dev'
  YARD::Parser::SourceParser.parser_type = :ruby18
end

module Yardstick
  ROOT = Pathname(__FILE__).dirname.parent.expand_path.freeze

  # Measure a list of files
  #
  # @example
  #   Yardstick.measure('article.rb')  # => [ Measurement ]
  #
  # @param [Array<#to_s>, #to_s] path
  #   optional list of paths to measure
  # @param [Hash] options
  #   optional configuration
  #
  # @return [Yardstick::MeasurementSet]
  #   the measurements for each file
  #
  # @api public
  def self.measure(path = 'lib/**/*.rb', options = {})
    Processor.process_path(path)
  end

  # Measure a string of code and YARD documentation
  #
  # @example
  #   string = "def my_method; end"
  #
  #   Yardstick.measure_string(string)  # => [ Measurement ]
  #
  # @param [#to_str] string
  #   the string to measure
  # @param [Hash] options
  #   optional configuration
  #
  # @return [Yardstick::MeasurementSet]
  #   the measurements for the string
  #
  # @api public
  def self.measure_string(string, options = {})
    Processor.process_string(string)
  end

end # module Yardstick
