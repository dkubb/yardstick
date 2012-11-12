module Yardstick
  module Measurable
    include Measurement::UtilityMethods

    module ClassMethods

      # Include the class or module with measurable class methods
      #
      # @param [Module] mod
      #   the module to include within
      #
      # @return [undefined]
      #
      # @api private
      def included(mod)
        mod.extend(ClassMethods).rules.merge(rules)
      end

      # List of rules for this class
      #
      # @return [Yardstick::RuleSet<Rule>]
      #   the rules for this class
      #
      # @api private
      def rules
        @rules ||= RuleSet.new
      end

      # Set the description for the rule
      #
      # @param [#to_str] description
      #   the rule description
      #
      # @yield []
      #   the rule to perform
      #
      # @yieldreturn [Boolean]
      #   return true if successful, false if not
      #
      # @return [undefined]
      #
      # @api private
      def rule(description, &block)
        rules << Rule.new(description, &block)
      end

    end # module ClassMethods

    extend ClassMethods

    # Return a list of measurements for this docstring instance
    #
    # @example
    #   docstring.measure  # => [ Measurement ]
    #
    # @return [Yardstick::MeasurementSet]
    #   a collection of measurements
    #
    # @api public
    def measure
      self.class.rules.measure(self)
    end

  end # module Measurable
end # module Yardstick
