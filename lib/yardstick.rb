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
  # @param [Array<#to_str>, #to_str] paths
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
require 'yardstick/autoload'

module YARD  #:nodoc: all
  module CodeObjects
    class MethodObject

      # Return the docstring associated with the method
      #
      # @example
      #   method_object.docstring  # => YARD::Docstring instance
      #
      # @return [YARD::Docstring]
      #   the docstring for this method
      #
      # @api public
      def docstring
        # TODO: update to use super() once reek does not flag it as
        #   a utility method
        @docstring.extend(Yardstick::Method)
      end

      # TODO: create an object to wrap tags, and extend each tag object with
      # the matching module, if one exists under Yardstick::Tag::*

    end # class MethodObject
  end # module CodeObjects
end # module YARD
