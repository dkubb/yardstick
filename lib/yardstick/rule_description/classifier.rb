module Yardstick
  # Rule description composed of tokens which can be formatted
  class RuleDescription
    # Token classification
    module Classifier
      # List of classifiers
      class List
        include Adamantium, Concord.new(:classifiers)

        # Classify a token by returning the first match
        #
        # @param token [String] markup text
        #
        # @return [Token]
        #
        # @api private
        def classify(token)
          classifiers.each do |classifier|
            classified = classifier.try(token)

            break classified if classified
          end
        end

        # Union pattern for splitting text based on patterns
        #
        # @return [Regexp]
        #
        # @api private
        def pattern
          Regexp.union(pattern_classifiers.map(&:pattern))
        end

      private

        # Classifiers which match based on a pattern
        #
        # @return [Array<Pattern>]
        #
        # @api private
        def pattern_classifiers
          classifiers.grep(Pattern)
        end
      end

      # Pattern based classifier
      class Pattern
        include Adamantium, Concord::Public.new(:type, :pattern)

        # Try to coerce text if it matches
        #
        # @param text [String]
        #
        # @return [Token] if match is successful
        # @return [nil] otherwise
        #
        # @api private
        def try(text)
          type.coerce(text) if match?(text)
        end

      private

        # Check if text matches the specified pattern
        #
        # @param text [String]
        #
        # @return [Boolean]
        #
        # @api private
        def match?(text)
          token_pattern.match(text)
        end

        # Pattern to match an entire token string
        #
        # @return [Regexp]
        #
        # @api private
        def token_pattern
          /\A#{pattern}\z/
        end
      end

      # Catch all classifier
      class Default
        include Adamantium, Concord.new(:type)

        # Coerces any string
        #
        # @param text [String]
        #
        # @return [Token]
        #
        # @api private
        def try(text)
          type.coerce(text)
        end
      end
    end
  end
end
