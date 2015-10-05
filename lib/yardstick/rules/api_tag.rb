# encoding: utf-8

module Yardstick
  module Rules
    # Rules related to @api tag
    #
    class ApiTag
      # Checks if @api tag is present
      #
      class Presence < Rule
        self.description = 'The @api tag should be specified'.freeze

        # @see class description
        #
        # @return [Boolean]
        #   true if valid
        #
        # @api private
        def valid?
          has_tag?('api')
        end
      end

      # Checks if @api tag is a public, semipublic or private
      #
      class Inclusion < Rule
        VALID_VALUES = %w[public semipublic private].freeze

        self.description = 'The @api tag must be either public, semipublic or private'.freeze

        # @see class description
        #
        # @return [Boolean]
        #   true if valid
        #
        # @api private
        def valid?
          VALID_VALUES.include?(tag_text('api'))
        end
      end

      # Checks if protected method has correct @api visibility
      #
      class ProtectedMethod < Rule
        self.description =
          'A method with protected visibility must have an @api tag of semipublic or private'.freeze

        # @see Rule::validatable?
        #
        # @return [Boolean]
        #   true if method visibility is protected
        #
        # @api private
        def validatable?
          visibility.equal?(:protected)
        end

        # @see class description
        #
        # @return [Boolean]
        #   true if api tag is semipublic or private
        #
        # @api private
        def valid?
          api?(%w[semipublic private])
        end
      end

      # Checks if private method has correct @api visibility
      #
      class PrivateMethod < Rule
        self.description =
          'A method with private visibility must have an @api tag of private'.freeze

        # @see Rule::validatable?
        #
        # @return [Boolean]
        #   true method visibility is private
        #
        # @api private
        def validatable?
          visibility.equal?(:private)
        end

        # @see class description
        #
        # @return [Boolean]
        #   true if api tag is private
        #
        # @api private
        def valid?
          api?(%w[private])
        end
      end
    end
  end
end
