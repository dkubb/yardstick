# encoding: utf-8

module Yardstick
  module Rules
    # Rules related to @api tag
    #
    class ApiTag
      # Checks if @api tag is present
      #
      class Presence < Rule
        describe '*@api* should be specified'.freeze

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

        describe '*@api* should be _public_, _semipublic_, or _private_'.freeze

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
        describe '*@api* should be _semipublic_ or _private_ for protected methods'.freeze

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
        describe '*@api* should be _private_ for private methods'.freeze

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
