module Yardstick
  class Processor
    # Measure files provided
    #
    # @param [Array<#to_str>] files
    #   the files to measure
    #
    # @return [Array<Measurement>]
    #   a collection of measurements
    #
    # @api private
    def self.process_files(files)
      YARD.parse(Pathname.glob(files).map { |file| file.to_str })
      measure_method_objects(method_objects)
    end

    # Measure string provided
    #
    # @param [#to_str] string
    #   the string to measure
    #
    # @return [Array<Measurement>]
    #   a collection of measurements
    #
    # @api private
    def self.process_string(string)
      YARD.parse_string(string.to_str)
      measure_method_objects(method_objects)
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

    # Measure the method objects provided
    #
    # @param [Array<YARD::CodeObjects::MethodObject>] method_objects
    #   a collection of method objects
    #
    # @return [Array<Measurement>]
    #   a collection of measurements
    #
    # @api private
    def self.measure_method_objects(method_objects)
      method_objects.map do |method_object|
        method_object.docstring.measure
      end.flatten
    end

    class << self
      private :method_objects
      private :measure_method_objects
    end
  end
end
