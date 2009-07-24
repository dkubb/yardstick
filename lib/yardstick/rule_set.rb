module Yardstick
  class RuleSet
    include Enumerable

    # Returns the RuleSet instance
    #
    # @return [RuleSet<Rule>]
    #   the rule set instance
    #
    # @api private
    def initialize
      @rules = []
    end

    # Append a Rule
    #
    # @param [Rule] rule
    #   the rule to append
    #
    # @return [RuleSet<Rule>]
    #   returns self
    #
    # @api private
    def <<(rule)
      @rules << rule unless @rules.include?(rule)
      self
    end

    # Merge in another RuleSet
    #
    # @param [RuleSet] other
    #   the other rule set
    #
    # @return [RuleSet<Rule>]
    #   returns self
    #
    # @api private
    def merge(other)
      other.each { |rule| self << rule }
      self
    end

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

    # Iterate over each Rule
    #
    # @yield [rule]
    #   yield to the Rule
    #
    # @yieldparam [Rule] rule
    #   a Rule in the RuleSet
    #
    # @return [RuleSet<Rule>]
    #   returns self
    #
    # @api private
    def each(&block)
      @rules.each(&block)
      self
    end

  end # class RuleSet
end # module Yardstick
