# encoding: utf-8

require 'pathname'
require 'rational'
require 'delegate'

require 'backports'
require 'yard'

require 'yardstick/ordered_set'
require 'yardstick/measurement'

require 'yardstick/config'
require 'yardstick/report_output'
require 'yardstick/document'

require 'yardstick/rule'
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
  #   Yardstick.measure('article.rb')  # => [ Measurement ]
  #
  # @param [Array<#to_s>, #to_s] path
  #   optional list of paths to measure
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

end # module Yardstick
