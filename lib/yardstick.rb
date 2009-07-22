require 'pathname'
require 'yard'

module Yardstick
  VERSION = '0.0.1'.freeze
  ROOT    = Pathname(__FILE__).dirname.parent.expand_path.freeze

  # Measure a list of files
  #
  # @example
  #   Yardstick.measure('article.rb')  # => [ Measurement ]
  #
  # @param [Array<#to_str>, #to_str] files
  #   optional list of paths to measure
  # @param [Hash] options
  #   optional configuration
  #
  # @return [Array<Measurement>]
  #   the measurements for each file
  #
  # @api public
  def self.measure(files = 'lib/**/*.rb', options = {})
    Yardstick::Processor.process_files(files)
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
  # @return [Array<Measurement>]
  #   the measurements for the string
  #
  # @api public
  def self.measure_string(string, options = {})
    Yardstick::Processor.process_string(string)
  end

end # module Yardstick

$LOAD_PATH << Yardstick::ROOT + 'lib'

require 'yardstick/core_ext/object'
require 'yardstick/yard_ext'
require 'yardstick/autoload'
