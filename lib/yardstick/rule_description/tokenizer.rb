module Yardstick
  # Rule description composed of tokens which can be formatted
  class RuleDescription
    # Rule description tokenizer
    #
    # Processes rule descriptions specified with simple markup
    # and splits the markup into {Token} components
    class Tokenizer
      include Adamantium, Concord.new(:text)

      # Mapping of token classes to their matching pattern
      CLASSIFIERS = Classifier::List.new([
        Classifier::Pattern.new(Token::Subject, /(\*[@\w ]+?\*)/),
        Classifier::Pattern.new(Token::Option, /(_[\w ]+?_)/),
        Classifier::Default.new(Token::Text)
      ])

      private_constant(:CLASSIFIERS)

      # Reduce text markup into tokens
      #
      # @return [Array<Token>]
      #
      # @api private
      def tokenize
        tokens.map(&CLASSIFIERS.method(:classify))
      end

    private

      # Raw input text broken into parts
      #
      # @return [Array<String>]
      #
      # @api private
      def tokens
        text.split(CLASSIFIERS.pattern).reject(&:empty?)
      end
    end
  end
end
