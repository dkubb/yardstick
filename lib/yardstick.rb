# encoding: utf-8

require 'set'
require 'pathname'
require 'delegate'

require 'yard'
require 'yard/logging'
require 'concord'

require 'yardstick/ordered_set'
require 'yardstick/measurement'

require 'yardstick/config'
require 'yardstick/report_output'
require 'yardstick/document'

require 'yardstick/rule'
require 'yardstick/rule_config'
require 'yardstick/rules/api_tag'
require 'yardstick/rules/example_tag'
require 'yardstick/rules/summary'
require 'yardstick/rules/return_tag'

require 'yardstick/measurement_set'
require 'yardstick/document_set'
require 'yardstick/processor'
require 'yardstick/parser'

require 'yardstick/yard_ext'

require 'yardstick/version'

module Yardstick
  ROOT = Pathname(__FILE__).dirname.parent.expand_path.freeze

  # Measure a list of files
  #
  # @example
  #   config = Yardstick::Config.coerce(path: 'article.rb')
  #   Yardstick.measure(config)  # => [ MeasurementSet ]
  #
  # @param [Config] config
  #   optional configuration
  #
  # @return [Yardstick::MeasurementSet]
  #   the measurements for each file
  #
  # @api public
  def self.measure(config = Config.new)
    Processor.new(config).process
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
  # @param [Config] config
  #   optional configuration
  #
  # @return [Yardstick::MeasurementSet]
  #   the measurements for the string
  #
  # @api public
  def self.measure_string(string, config = Config.new)
    Processor.new(config).process_string(string)
  end

  # Round percentage to 1/10th of a percent
  #
  # @param [Float] percentage
  #   the percentage to round
  #
  # @return [Float]
  #   the rounded percentage
  #
  # @api private
  def self.round_percentage(percentage)
    (percentage * 10).floor / 10.0
  end
end # module Yardstick
