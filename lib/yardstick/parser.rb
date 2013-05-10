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
      YARD.parse(paths, [], YARD::Logger::ERROR)
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
      method_objects.each_with_object(DocumentSet.new) do |method_object, set|
        set << Document.new(method_object.docstring)
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
      YARD::Registry.all(:method).sort_by do |method_object|
        [ method_object.file, method_object.line ]
      end
    ensure
      YARD::Registry.clear
    end
    private_class_method :method_objects

  end
end
