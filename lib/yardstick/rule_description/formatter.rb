# frozen_string_literal: true

# Measure YARD documentation coverage
module Yardstick
  # Parsed rule description composed of formatted tokens
  class RuleDescription
    # @!attribute [r] description
    #   The rule description to format
    #   @api private
    #   @return [RuleDescription]
    FormatterData = Data.define(:description)
    private_constant :FormatterData

    # Rule description text formatter
    class Formatter < FormatterData
      # Map of token types to decorators
      TOKEN_DECORATORS = {
        Token::Subject => Decorator::RED_BOLD,
        Token::Option => Decorator::YELLOW_UNDERLINED,
        Token::Text => Decorator::NONE
      }.freeze

      # Translate rule description tokens into a single decorated string
      #
      # @return [String]
      #
      # @api private
      def format
        decorated_tokens.join
      end

    private

      # List of decorated token strings
      #
      # @return [Array<String>]
      #
      # @api private
      def decorated_tokens
        description.map(&:decorate)
      end

      # Null formatter
      class Null < self
        # Returns an unformatted single string
        #
        # @return [String]
        #
        # @api private
        def format
          description.to_a.join
        end
      end
    end
  end
end
