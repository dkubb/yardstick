module Yardstick
  module Rules
    # Checks if method has a @return tag
    #
    class ReturnTag < Rule
      self.description = 'The @return tag should be specified'

      # @see class description
      #
      # @return [Boolean]
      #   true if has return tag
      #
      # @api private
      def valid?
        has_tag?('return')
      end
    end
  end
end
