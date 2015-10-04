# encoding: utf-8

module Yardstick
  # Config class for rules
  #
  # It is used to check if document should be validated or not.
  #
  class RuleConfig
    include Concord.new(:enabled, :exclude)

    METHOD_SEPARATOR = /\#|\./.freeze

    # Initializes new instance of rule config
    #
    # @param [Hash] options
    #   optional configuration
    #
    # @return [Yardstick::RuleConfig]
    #
    # @api private
    def initialize(options = {})
      super(options.fetch(:enabled, true), options.fetch(:exclude, []))
    end

    # Checks if given path should be checked using this rule
    #
    # @param [String] path
    #   document path, e.g "Foo::Bar#baz"
    #
    # @return [Boolean]
    #   true if path should be checked
    #
    # @api private
    def enabled_for_path?(path)
      enabled && !exclude?(path)
    end

    private

    # Checks if given path is in exclude list
    #
    # If exact match fails then checks if the method class is in the exclude
    # list.
    #
    # @param [String] path
    #   document path
    #
    # @return [Boolean]
    #   true if path is in the exclude list
    #
    # @api private
    def exclude?(path)
      exclude.include?(path) ||
        exclude.include?(path.split(METHOD_SEPARATOR).first)
    end
  end
end
