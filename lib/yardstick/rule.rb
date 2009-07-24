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

  end # module Rule
end # module Yardstick
