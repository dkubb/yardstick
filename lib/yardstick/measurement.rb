# encoding: utf-8

module Yardstick
  # A measurement given a constraint on the docs
  class Measurement
    # Return a Measurement instance
    #
    # @example
    #   measurement = Measurement.new(document, rule)
    #
    # @param [Yardstick::Document] document
    # @param [Yardstick::Rule] rule
    #
    # @return [Yardstick::Measurement]
    #   the measurement instance
    #
    # @api public
    def initialize(rule)
      @document = rule.document
      @rule     = rule
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
      skip? || @result
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
      @result.equal?(:skip)
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
      return if ok?
      io.puts("#{@document.file}:#{@document.line}: #{@document.path}: #{description}")
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
