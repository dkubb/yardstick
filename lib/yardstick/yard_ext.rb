module YARD  #:nodoc: all
  module CodeObjects

    # A YARD extension
    class MethodObject

      # Return the docstring associated with the method
      #
      # @example
      #   method_object.docstring  # => YARD::Docstring instance
      #
      # @return [YARD::Docstring]
      #   the docstring for this method
      #
      # @api public
      def docstring
        super.extend(Yardstick::Method)
      end

    end # class MethodObject
  end # module CodeObjects
end # module YARD
