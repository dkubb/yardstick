module Yardstick
  module Measurable
    include Measurement::UtilityMethods

    module ClassMethods

      # List of rules for this class
      #
      # @return [Array<Array(String, Symbol)>]
      #   the rules for this class
      #
      # @api private
      def rules
        @rules ||= []
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
        rules << [ description, block ]
      end

    private

      # Include the class or module with measurable class methods
      #
      # @param [Module] mod
      #   the module to include within
      #
      # @return [undefined]
      #
      # @api private
      def included(mod)
        mod.extend(ClassMethods)
        copy_rules(mod)
      end

      # Extend the docstring meta class with measurable class methods
      #
      # @param [YARD::Docstring] docstring
      #   the docstring to extend
      #
      # @return [undefined]
      #
      # @api private
      def extended(docstring)
        meta_class = docstring.meta_class
        meta_class.extend(ClassMethods)
        copy_rules(meta_class)
      end

      # Copy rules from the ancestor to the descendant
      #
      # @param [Module] descendant
      #   the descendant module or class
      #
      # @return [undefined]
      #
      # @api private
      def copy_rules(descendant)
        descendant.rules.concat(rules).uniq!
      end
    end # module ClassMethods

    extend ClassMethods

    # Return a list of measurements for this docstring instance
    #
    # @example
    #   docstring.measure  # => [ Measurement ]
    #
    # @return [Array<Measurement>]
    #   a collection of measurements
    #
    # @api public
    def measure
      meta_class.rules.map do |(description, block)|
        Measurement.new(description, self, &block)
      end
    end

  end # module Measurable
end # module Yardstick
