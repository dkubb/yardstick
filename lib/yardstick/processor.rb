# encoding: utf-8

module Yardstick

  # Handle procesing a docstring or path of files
  class Processor

    # Measure files provided
    #
    # @param [Array<#to_s>, #to_s] path
    #   the files to measure
    # @param [Config] config
    #   a configuration
    #
    # @return [Yardstick::MeasurementSet]
    #   a collection of measurements
    #
    # @api private
    def self.process_path(config)
      YARD.parse(paths(config), [], YARD::Logger::ERROR)
      measurements(config)
    end

    # Measure string provided
    #
    # @param [#to_str] string
    #   the string to measure
    # @param [Config] config
    #   a configuration
    #
    # @return [Yardstick::MeasurementSet]
    #   a collection of measurements
    #
    # @api private
    def self.process_string(string, config)
      YARD.parse_string(string.to_str)
      measurements(config)
    end

    # Measure method objects in YARD registry
    #
    # @return [Yardstick::MeasurementSet]
    #   a collection of measurements
    # @param [Config] config
    #   a configuration
    #
    # @api private
    def self.measurements(config)
      measurements = MeasurementSet.new
      method_objects.each do |method_object|
        measurements.merge(Document.measure(method_object.docstring, config))
      end
      measurements
    end

    # Return method objects in YARD registry
    #
    # @return [Array<YARD::CodeObjects::MethodObject>]
    #   a collection of method objects
    #
    # @api private
    def self.method_objects
      YARD::Registry.all(:method).sort_by do |method_object|
        [ method_object.file, method_object.line ]
      end
    ensure
      YARD::Registry.clear
    end

    # Return config's possible paths
    #
    # @return [Array<String>]
    #
    # @api private
    def self.paths(config)
      Array(config.path).map(&:to_s)
    end

    class << self
      private :measurements, :method_objects, :paths
    end

  end # class Processor
end # module Yardstick
