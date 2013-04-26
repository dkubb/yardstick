module Yardstick
  module Rules
    # Rules related to method summary
    #
    class Summary
      # Checks if method summary is present
      #
      class Presence < Rule
        self.description = 'The method summary should be specified'

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
          summary_text != ''
        end
      end

      # Checks that method summary length doesn't go over 80 characters
      #
      class Length < Rule
        self.description = 'The method summary should be less than 80 characters in length'

        # @see class description
        #
        # @return [Boolean]
        #   true if summary length is below 80 characters
        #
        # @api private
        def valid?
          summary_text.split(//).length <= 80
        end
      end

      # Checks that method summary doesn't end with a period
      #
      class Delimiter < Rule
        self.description = 'The method summary should not end in a period'

        # @see class description
        #
        # @return [Boolean]
        #   true if summary text does not end with a period
        #
        # @api private
        def valid?
          summary_text[-1, 1] != '.'
        end
      end

      # Checks that method summary length is exactly one line
      #
      class SingleLine < Rule
        self.description = 'The method summary should be a single line'

        # @see class description
        #
        # @return [Boolean]
        #   true if summary text does not include a new line
        #
        # @api private
        def valid?
          !summary_text.include?("\n")
        end
      end
    end
  end
end
