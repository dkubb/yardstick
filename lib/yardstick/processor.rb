# frozen_string_literal: true

# Measure YARD documentation coverage
module Yardstick
  # Holds the attributes for a Processor
  # @!attribute [r] config
  #   The yardstick configuration
  #   @api private
  #   @return [Yardstick::Config]
  ProcessorData = Data.define(:config)
  private_constant :ProcessorData

  # Handle procesing a docstring or path of files
  class Processor < ProcessorData
    # Measure files specified in the config
    #
    # @return [Yardstick::MeasurementSet]
    #   a collection of measurements
    #
    # @api private
    def process
      Parser.parse_paths(paths).measure(config)
    end

    # Measure string provided
    #
    # @param [#to_str] string
    #   the string to measure
    #
    # @return [Yardstick::MeasurementSet]
    #   a collection of measurements
    #
    # @api private
    def process_string(string)
      Parser.parse_string(string).measure(config)
    end

    private

    # Return config's possible paths
    #
    # @return [Array<String>]
    #
    # @api private
    def paths
      Array(config.path).map(&:to_s)
    end
  end
end
