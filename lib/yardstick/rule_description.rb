# frozen_string_literal: true

# Measure YARD documentation coverage
module Yardstick
  # @!attribute [r] tokens
  #   The parsed description tokens
  #   @api private
  #   @return [Array<RuleDescription::Token>]
  RuleDescriptionData = Data.define(:tokens)
  private_constant :RuleDescriptionData

  # Rule description composed of tokens which can be formatted
  class RuleDescription < RuleDescriptionData
    extend Forwardable

    # Parse a rule description into tokens and initialize
    #
    # @param description [String] plain test description
    #
    # @return [RuleDescription]
    #
    # @api private
    def self.parse(description)
      new(tokens: Tokenizer.new(text: description).tokenize)
    end

    include Enumerable

    # @!method each
    # Iterate over each token in description
    #
    # @return [Enumerable]
    # @yield [Token]
    #
    # @api private
    def_delegators :tokens, :each
  end
end
