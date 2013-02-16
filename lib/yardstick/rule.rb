# encoding: utf-8

module Yardstick

  # A constraint on the docs
  class Rule

    # Return a Rule instance
    #
    # @param [#to_str] description
    #   the description of the Rule
    #
    # @yield []
    #   the measurement for the rule
    #
    # @return [Rule]
    #   the rule instance
    #
    # @api private
    def initialize(description, &block)
      @description = description.to_str
      @block       = block
    end

    # Return a Measurement for a docstring
    #
    # @param [YARD::Docstring] docstring
    #   the docstring to measure
    #
    # @return [Measurement]
    #   the measurement
    #
    # @api private
    def measure(docstring)
      Measurement.new(@description, docstring, &@block)
    end

    # Test if Rule is equal to another rule
    #
    # @example
    #   rule == equal_rule  # => true
    #
    # @param [Rule] other
    #   the other Rule
    #
    # @return [Boolean]
    #   true if the Rule is equal to the other, false if not
    #
    # @api semipublic
    def eql?(other)
      @description.eql?(other.instance_variable_get(:@description))
    end

    # Return hash identifier for the Rule
    #
    # @return [Integer]
    #   the hash identifier
    #
    # @api private
    def hash
      @description.hash
    end

  end # class Rule
end # module Yardstick
