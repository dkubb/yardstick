module Yardstick
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

    # Test if Rule is equivalent to another rule
    #
    # @example
    #   rule == equivalent_rule  # => true
    #
    # @param [Rule] other
    #   the other Rule
    #
    # @return [Boolean]
    #   true if the Rule is equivalent to the other, false if not
    #
    # @api semipublic
    def ==(other)
      @description == other.instance_variable_get(:@description)
    end

  end # class Rule
end # module Yardstick
