module Yardstick
  # Rule description composed of tokens which can be formatted
  class RuleDescription
    # @abstract string token
    class Token
      extend Forwardable

      # Coerce string token into unformatted text
      #
      # @param string [String] token text with markup
      #
      # @return [Token]
      #
      # @api private
      def self.coerce(string)
        new(string[1..-2])
      end

      include AbstractType, Adamantium, Concord.new(:string)

      # Decorate using decorator specified by token type
      #
      # @return [String]
      #
      # @api private
      def decorate
        self.class::DECORATOR.decorate(string)
      end

      # @!method to_str
      # String primitive representation of token
      #
      # @return [String]
      #
      # @api private
      def_delegator :string, :to_str

      # Token representing the subject of a rule description
      class Subject < self
        DECORATOR = Decorator::RED_BOLD
      end

      # Token representing an option for resolving a rule violation
      class Option < self
        DECORATOR = Decorator::YELLOW_UNDERLINED
      end

      # Plain text token
      class Text < self
        DECORATOR = Decorator::NONE

        # Represent plain text without markup as a token
        #
        # @param string [String]
        #
        # @return [Token]
        #
        # @api private
        def self.coerce(string)
          new(string)
        end
      end
    end
  end
end
