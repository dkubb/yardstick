module Yardstick

  # A set of rules to apply to docs
  class RuleSet < OrderedSet

    # Measure a docstring with all Rules
    #
    # @param [YARD::Docstring] docstring
    #   the docstring to measure
    #
    # @return [MeasurementSet]
    #   a collection of measurements
    #
    # @api private
    def measure(docstring)
      MeasurementSet.new(map { |rule| rule.measure(docstring) })
    end

  end # class RuleSet
end # module Yardstick
