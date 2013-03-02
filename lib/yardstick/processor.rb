# encoding: utf-8

module Yardstick

  # Handle procesing a docstring or path of files
  class Processor

    # Measure files provided
    #
    # @param [Array<#to_s>, #to_s] path
    #   the files to measure
    #
    # @return [Yardstick::MeasurementSet]
    #   a collection of measurements
    #
    # @api private
    def self.process_path(path)
      YARD.parse(Array(path).map(&:to_s), [], YARD::Logger::ERROR)
      measurements
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
    def self.process_string(string)
      YARD.parse_string(string.to_str)
      measurements
    end

    # Measure method objects in YARD registry
    #
    # @return [Yardstick::MeasurementSet]
    #   a collection of measurements
    #
    # @api private
    def self.measurements
      measurements = MeasurementSet.new
      method_objects.each do |method_object|
        measurements.merge(method_object.docstring.measure)
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

    class << self
      private :measurements, :method_objects
    end

  end # class Processor
end # module Yardstick
