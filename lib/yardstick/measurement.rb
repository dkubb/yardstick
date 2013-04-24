# encoding: utf-8

module Yardstick

  # A measurement given a constraint on the docs
  class Measurement
    # Return measurable rule
    #
    # @return [Rules::Rule]
    #
    # @api private
    attr_reader :rule

    # Return a Measurement instance
    #
    # @example
    #   measurement = Measurement.new('The description', docstring, :successful_method)
    #
    # @param [Document] document
    # @param [Class] rule_class
    #
    # @return [Yardstick::Measurement]
    #   the measurement instance
    #
    # @api public
    def initialize(document, rule_class)
      @document = document
      @rule     = rule_class.new(document)
      @result   = measure
    end

    # Return true if the measurement was successful
    #
    # @example Measurement successful
    #   measurement.ok?  # => true
    #
    # @example Measurement unsuccessful
    #   measurement.ok?  # => false
    #
    # @return [Boolean]
    #   true if the measurement was successful, false if not
    #
    # @api public
    def ok?
      @result == true || skip?
    end

    # Return true if the measurement was skipped
    #
    # @example Measurement skipped
    #   measurement.skip?  # => true
    #
    # @example Measurement not skipped
    #   measurement.skip?  # => false
    #
    # @return [Boolean]
    #   true if the measurement was skipped, false if not
    #
    # @api public
    def skip?
      @result == :skip
    end

    # Warns the results the measurement if it was not successful
    #
    # @example
    #   measurement.puts  # (outputs results if not successful)
    #
    # @param [#puts] io
    #   optional object to puts the summary
    #
    # @return [undefined]
    #
    # @api public
    def puts(io = $stdout)
      unless ok?
        io.puts("#{@document.file}:#{@document.line}: #{@document.path}: #{description}")
      end
    end

    # Test if Measurement is equal to another measurement
    #
    # @example
    #   measurement == equal_measurement  # => true
    #
    # @param [Yardstick::Measurement] other
    #   the other Measurement
    #
    # @return [Boolean]
    #   true if the Measurement is equal to the other, false if not
    #
    # @api semipublic
    def eql?(other)
      @rule.eql?(other.rule)
    end

    # Return hash identifier for the Measurement
    #
    # @return [Integer]
    #   the hash identifier
    #
    # @api private
    def hash
      description.hash ^ @document.hash
    end

    # Return the Measurement description
    #
    # @example
    #   measurement.description  # => "The description"
    #
    # @return [String]
    #   the description
    #
    # @api public
    def description
      @rule.class.description
    end

  private

    # Measure the document using the rule provided to the constructor
    #
    # @return [Boolean, Symbol]
    #   true if the test is successful, false if not
    #   :skip if the test does not apply
    #
    # @api private
    def measure
      return :skip if !@rule.enabled? || !@rule.validatable?
      @rule.valid?
    end

  end # class Measurement
end # module Yardstick
