module Yardstick
  class RuleDescription
    # Rule description text formatter
    class Formatter
      include Concord.new(:description)

      # Map of token types to decorators
      TOKEN_DECORATORS = IceNine.deep_freeze(
        Token::Subject => Decorator::RED_BOLD,
        Token::Option  => Decorator::YELLOW_UNDERLINED,
        Token::Text    => Decorator::NONE
      )

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
