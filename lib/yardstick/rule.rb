module Yardstick
  # Base class of every rule
  #
  # @abstract
  class Rule
    extend Forwardable

    class << self
      # Description of the rule
      #
      # This is shown when a rule is invalid
      #
      # @return [String]
      #
      # @api private
      attr_accessor :description
    end

    # Return document
    #
    # @return [Document]
    #
    # @api private
    attr_reader :document

    # Initializes a rule
    #
    # @param [Document] document
    # @param [Hash] options
    #   optional configuration
    #
    # @return [Rule]
    #
    # @api private
    def initialize(document, options = {})
      @document = document
      @enabled  = options.fetch(:enabled, true)
      @exclude  = options.fetch(:exclude, [])
    end

    def_delegators :@document, :has_tag?, :api?, :tag_types, :tag_text, :summary_text, :visibility

    # Checks if rule is enabled in current context
    #
    # @return [Boolean]
    #   true if enabled
    #
    # @api private
    def enabled?
      @enabled && !@exclude.include?(@document.path)
    end

    # Checks if the rule is validatable for given document
    #
    # @return [Boolean]
    #
    # @api private
    def validatable?
      true
    end
  end
end
