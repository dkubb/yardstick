# encoding: utf-8

module Yardstick
  module Rules
    # Checks if method has @example tag
    #
    # This applies only for public methods
    #
    class ExampleTag < Rule
      describe '*@example* should be specified for _public_ and _semipublic_ methods'.freeze

      # @see class description
      #
      # @return [Boolean]
      #   true if method is not private and it returns something meaningful
      #
      # @api private
      def validatable?
        !api?(%w[private]) && !tag_types('return').eql?(%w[undefined])
      end

      # @see class description
      #
      # @return [Boolean]
      #   true if has example tag
      #
      # @api private
      def valid?
        has_tag?('example')
      end
    end
  end
end
