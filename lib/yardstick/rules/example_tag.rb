module Yardstick
  module Rules
    # Checks if method has @example tag
    #
    # This applies only for public methods
    #
    class ExampleTag < Rule
      self.description = 'The public/semipublic method should have an example specified'

      # @see class description
      #
      # @return [Boolean]
      #   true if method is not private and it returns something meaningful
      #
      # @api private
      def validatable?
        !api?(%w[ private ]) && tag_types('return') != %w[ undefined ]
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
