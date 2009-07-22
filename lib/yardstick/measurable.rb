module Yardstick
  module Measurable
    include Measurement::UtilityMethods

    module ClassMethods

      # List of measurement types for this class
      #
      # @return [Array<Array(String, Symbol)>]
      #
      # @api private
      def measurements
        @measurements ||= []
      end

      # Set the description for the next method
      #
      # @return [undefined]
      #
      # @api private
      def measurement(description, &block)
        measurements << [ description, block ]
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
        copy_measurements(mod)
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
        copy_measurements(meta_class)
      end

      # Copy measurements from the ancestor to the descendant
      #
      # @param [Module] descendant
      #   the descendant module or class
      #
      # @return [undefined]
      #
      # @api private
      def copy_measurements(descendant)
        descendant.measurements.concat(measurements).uniq!
      end
    end # module ClassMethods

    extend ClassMethods

    # Return a list of measurements for this docstring instance
    #
    # @example
    #   docstring.measure  # => [ Measurement ]
    #
    # @return [Array<Measurement>]
    #
    # @api public
    def measure
      meta_class.measurements.map do |(description, block)|
        Measurement.new(description, self, &block)
      end
    end

  end # module Measurable
end # module Yardstick
