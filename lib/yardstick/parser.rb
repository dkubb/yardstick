# encoding: utf-8

module Yardstick
  # Parses files and strings using YARD
  class Parser
    # Measure files specified in the paths
    #
    # @return [Array<Document>]
    #   a collection of parsed documents
    #
    # @api private
    def self.parse_paths(paths)
      YARD.parse(paths, [], Logger::ERROR)
      documents
    end

    # Measure string provided
    #
    # @param [#to_str] string
    #   the string to measure
    #
    # @return [Array<Document>]
    #   a collection of parsed documents
    #
    # @api private
    def self.parse_string(string)
      YARD.parse_string(string.to_str)
      documents
    end

    # Coerces method objects into documents
    #
    # @return [Yardstick::DocumentSet]
    #
    # @api private
    def self.documents
      method_objects.reduce(DocumentSet.new) do |set, method_object|
        set << Document.new(method_object.docstring)
        set
      end
    end
    private_class_method :documents

    # Return method objects in YARD registry
    #
    # @return [Array<YARD::CodeObjects::MethodObject>]
    #   a collection of method objects
    #
    # @api private
    def self.method_objects
      YARD::Registry.all(:method).select(&:file).select(&:line).sort_by do |method_object|
        [method_object.file, method_object.line]
      end
    ensure
      YARD::Registry.clear
    end
    private_class_method :method_objects
  end
end
