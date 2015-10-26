module Yardstick
  # Rule description composed of tokens which can be formatted
  class RuleDescription
    extend Forwardable

    # Parse a rule description into tokens and initialize
    #
    # @param description [String] plain test description
    #
    # @return [RuleDescription]
    #
    # @api private
    def self.parse(description)
      new(Tokenizer.new(description).tokenize)
    end

    include Adamantium, Concord.new(:tokens), Enumerable

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
