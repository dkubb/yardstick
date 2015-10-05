# encoding: utf-8

module Yardstick
  module Rules
    # Rules related to method summary
    #
    class Summary
      # Checks if method summary is present
      #
      class Presence < Rule
        self.description = 'The method summary should be specified'.freeze

        # @see Rule::validatable?
        #
        # @return [Boolean]
        #   true if method does not have @see tag
        #
        # @api private
        def validatable?
          !has_tag?('see')
        end

        # @see class description
        #
        # @return [Boolean]
        #   true if summary text is not empty
        #
        # @api private
        def valid?
          !summary_text.empty?
        end
      end

      # Checks that method summary length doesn't go over 80 characters
      #
      class Length < Rule
        MAXIMUM_LINE_LENGTH = 79

        self.description =
          'The method summary should be less than or equal to 79 characters in length'.freeze

        # @see class description
        #
        # @return [Boolean]
        #   true if summary length is below 80 characters
        #
        # @api private
        def valid?
          summary_text.split(//u).count <= MAXIMUM_LINE_LENGTH
        end
      end

      # Checks that method summary doesn't end with a period
      #
      class Delimiter < Rule
        self.description = 'The method summary should not end in a period'.freeze

        # @see class description
        #
        # @return [Boolean]
        #   true if summary text does not end with a period
        #
        # @api private
        def valid?
          !summary_text.end_with?('.')
        end
      end

      # Checks that method summary length is exactly one line
      #
      class SingleLine < Rule
        LINE_BREAK_CHARACTER = "\n"

        self.description = 'The method summary should be a single line'.freeze

        # @see class description
        #
        # @return [Boolean]
        #   true if summary text does not include a new line
        #
        # @api private
        def valid?
          !summary_text.include?(LINE_BREAK_CHARACTER)
        end
      end
    end
  end
end
