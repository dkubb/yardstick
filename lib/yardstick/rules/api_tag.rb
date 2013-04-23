module Yardstick
  module Rules
    # Rules related to @api tag
    #
    class ApiTag
      # Checks if @api tag is present
      #
      class Presence < Rule
        self.description = 'The @api tag should be specified'

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
        self.description = 'The @api tag must be either public, semipublic or private'

        # @see class description
        #
        # @return [Boolean]
        #   true if valid
        #
        # @api private
        def valid?
          %w[ public semipublic private ].include?(tag_text('api'))
        end
      end

      class ProtectedMethod < Rule
        self.description = 'A method with protected visibility must have an @api tag of semipublic or private'

        # @see Rule::validatable?
        #
        # @return [Boolean]
        #   true if method visibility is protected
        #
        # @api private
        def validatable?
          visibility == :protected
        end

        # @see class description
        #
        # @return [Boolean]
        #   true if has api tag semipublic or private
        #
        # @api private
        def valid?
          api?(%w[ semipublic private ])
        end
      end

      class PrivateMethod < Rule
        self.description = 'A method with private visibility must have an @api tag of private'

        # @see Rule::validatable?
        #
        # @return [Boolean]
        #   true method visibility is private
        #
        # @api private
        def validatable?
          visibility == :private
        end

        # @see class description
        #
        # @return [Boolean]
        #   true if validatable
        #
        # @api private
        def valid?
          api?(%w[ private ])
        end
      end
    end
  end
end
