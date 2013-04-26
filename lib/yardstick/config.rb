module Yardstick
  # Handles Yardstick configuration
  #
  class Config
    NAMESPACE_PREFIX = 'Yardstick::Rules::'.freeze

    # Set the threshold
    #
    # @return [undefined]
    #
    # @api public
    attr_writer :threshold

    # Threshold value
    #
    # @return [Integer]
    #
    # @api private
    attr_reader :threshold

    # Specify if the threshold should match the coverage
    #
    # @return [undefined]
    #
    # @api public
    attr_writer :require_exact_threshold

    # Return if the threshold should match the coverage
    #
    # @return [Boolean]
    #
    # @api private
    attr_reader :require_exact_threshold

    # List of paths to measure
    #
    # @return [undefined]
    #
    # @api public
    attr_writer :path

    # List of paths to measure
    #
    # @return [String]
    #
    # @api private
    attr_reader :path

    # Specify if the coverage summary should be displayed
    #
    # @return [undefined]
    #
    # @api public
    attr_writer :verbose

    # Specify if the coverage summary should be displayed
    #
    # @return [Boolean]
    #
    # @api private
    attr_reader :verbose

    # Coverts string keys into symbol keys
    #
    # @param [Hash] hash
    #
    # @return [Hash]
    #   normalized hash
    #
    # @api private
    def self.normalize_hash(hash)
      hash.each_with_object({}) { |(key, value), normalized_hash|
        normalized_value = value.is_a?(Hash) ? normalize_hash(value) : value
        normalized_hash[key.to_sym] = normalized_value
      }
    end

    # Initializes new config
    #
    # @param [Hash] options
    #   optional configuration
    #
    # @return [Yardstick::Config]
    #
    # @api private
    def initialize(options = {}, &block)
      @options = self.class.normalize_hash(options)
      @rules   = @options.fetch(:rules, {})

      @threshold               = @options.fetch(:threshold, nil)
      @verbose                 = true
      @path                    = 'lib/**/*.rb'
      @require_exact_threshold = true

      yield(self) if block_given?
    end

    # Return options for given rule
    #
    # @param [Class] rule_class
    #
    # @return [Hash]
    #
    # @api private
    def options(rule_class)
      key = rule_class.to_s[NAMESPACE_PREFIX.length..-1].to_sym
      @rules.fetch(key, {})
    end
  end
end
