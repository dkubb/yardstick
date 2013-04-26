module Yardstick
  class Document
    extend Forwardable

    # Measures docstring againg enabled rules
    #
    # @param [Yard::Docstring] docstring
    #   docstring that will be measured
    # @param [Config] config
    #   a configuration
    #
    # @return [MeasurementSet]
    #
    # @api private
    def self.measure(docstring, config)
      document = new(docstring)

      enabled_rules = [
        Rules::Summary::Presence,
        Rules::Summary::Length,
        Rules::Summary::Delimiter,
        Rules::Summary::SingleLine,
        Rules::ExampleTag,
        Rules::ApiTag::Presence,
        Rules::ApiTag::Inclusion,
        Rules::ApiTag::ProtectedMethod,
        Rules::ApiTag::PrivateMethod,
        Rules::ReturnTag
      ]

      MeasurementSet.new(enabled_rules.map { |rule_class|
        Measurement.new(document, rule_class.new(document, config.options(rule_class)))
      })
    end

    # Initializes Document object with docstring
    #
    # @param [Yard::Docstirng]
    #
    # @return [undefined]
    #
    # @api private
    def initialize(docstring)
      @docstring = docstring
    end

    def_delegators :@docstring, :has_tag?, :hash

    # The raw text for the summary
    #
    # @return [String]
    #   the summary text
    #
    # @api private
    def summary_text
      @docstring.split(/\r?\n\r?\n/).first || ''
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
      @docstring.tag(tag_name).text if has_tag?(tag_name)
    end

    # The types for a specified tag
    #
    # @param [String] tag_name
    #   the name of the tag
    #
    # @return [Array<String>, nil]
    #   a collection of tag types if the tag exists
    #
    # @api private
    def tag_types(tag_name)
      @docstring.tag(tag_name).types if has_tag?(tag_name)
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
      @docstring.object
    end
  end
end