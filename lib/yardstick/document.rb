# encoding: utf-8

module Yardstick
  # Wraps a yard docstring to make a nicer interface
  class Document
    @registered_rules = Set.new

    class << self
      # Shows currently registered rules
      #
      # @return [Array<Class>]
      #
      # @api private
      attr_reader :registered_rules
    end

    # Register rule with document
    #
    # @param [Class] rule_class
    #   subclass of Yardstick::Rule
    #
    # @return [undefined]
    #
    # @api private
    def self.register_rule(rule_class)
      registered_rules << rule_class
    end

    # Measures docstring against enabled rules
    #
    # @param [Yardstring::Document] document
    #   document that will be measured
    # @param [Yardstick::Config] config
    #   a configuration
    #
    # @return [MeasurementSet]
    #
    # @api private
    def self.measure(document, config)
      MeasurementSet.new(
        registered_rules.map do |rule_class|
          Measurement.new(rule_class.coerce(document, config))
        end
      )
    end

    # @!attribute [r] docstring
    #
    # Return document yard docstring
    #
    # @return [YARD::Docstring]
    #
    # @api private
    include Concord::Public.new(:docstring)

    # The raw text for the summary
    #
    # @return [String]
    #   the summary text
    #
    # @api private
    def summary_text
      docstring.split(/\r?\n\r?\n/).first.to_s
    end

    # Tests if document has a tag
    #
    # @param [String] name
    #   the name of the tag
    #
    # @return [Boolean]
    #   true if tag exists
    #
    # @api private
    def has_tag?(name) # rubocop:disable PredicateName
      docstring.has_tag?(name)
    end

    # The text for a specified tag
    #
    # @param [String] tag_name
    #   the name of the tag
    #
    # @return [String, nil]
    #   the tag text if the tag exists
    #
    # @api private
    def tag_text(tag_name)
      tag(tag_name).text
    end

    # The types for a specified tag
    #
    # @param [String] tag_name
    #   the name of the tag
    #
    # @return [Array<String>]
    #   a collection of tag types
    #
    # @api private
    def tag_types(tag_name)
      tag(tag_name).types
    end

    # The method visibility: public, protected or private
    #
    # @return [Symbol]
    #   the visibility of the method
    #
    # @api private
    def visibility
      object.visibility
    end

    # Check if the method API type matches
    #
    # @param [Array<String>] types
    #   a collection of API types
    #
    # @return [Boolean]
    #   true if the API type matches
    #
    # @api private
    def api?(types)
      types.include?(tag_text('api'))
    end

    # The filename for the code
    #
    # @return [Pathname]
    #   the filename
    #
    # @api private
    def file
      Pathname(object.file)
    end

    # The line number for the code
    #
    # @return [Integer]
    #   the line number
    #
    # @api private
    def line
      object.line
    end

    # The class and method name for the code
    #
    # @return [String]
    #   the class and method name
    #
    # @api private
    def path
      object.path
    end

    private

    # The code object for the docstring
    #
    # @return [YARD::CodeObjects::Base]
    #   the code object
    #
    # @api private
    def object
      docstring.object
    end

    # Finds tag by tag name
    #
    # @param [String] name
    #   the name of the tag
    #
    # @return [YARD::Tags::Tag, NullTag]
    #
    # @api private
    def tag(name)
      docstring.tag(name) || NullTag.new
    end

    # Null object for YARD::Tags::Tag
    #
    class NullTag
      # Empty text
      #
      # @return [nil]
      #
      # @api private
      def text
      end

      # Empty list of types
      #
      # @return [Array]
      #   an empty array
      #
      # @api private
      def types
        []
      end
    end
  end
end
