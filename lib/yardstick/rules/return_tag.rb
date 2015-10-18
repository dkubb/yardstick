# encoding: utf-8

module Yardstick
  module Rules
    # Checks if method has a @return tag
    #
    class ReturnTag < Rule
      describe '*@return* should be specified'.freeze

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
