module YARD  #:nodoc: all
  module CodeObjects
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

      # TODO: create an object to wrap tags, and extend each tag object with
      # the matching module, if one exists under Yardstick::Tag::*

    end # class MethodObject
  end # module CodeObjects
end # module YARD
