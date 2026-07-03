# frozen_string_literal: true

module Yardstick
  # Rule description composed of tokens which can be formatted
  class RuleDescription
    # @!attribute [r] text
    #   The text to tokenize
    #   @api private
    #   @return [String]
    TokenizerData = Data.define(:text)
    private_constant :TokenizerData

    # Rule description tokenizer
    #
    # Processes rule descriptions specified with simple markup
    # and splits the markup into {Token} components
    class Tokenizer < TokenizerData
      # Mapping of token classes to their matching pattern
      CLASSIFIERS = Classifier::List.new(classifiers: [
                                           Classifier::Pattern.new(type: Token::Subject, pattern: /(\*[@\w ]+?\*)/),
                                           Classifier::Pattern.new(type: Token::Option,  pattern: /(_[\w ]+?_)/),
                                           Classifier::Default.new(type: Token::Text)
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
