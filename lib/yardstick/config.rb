# frozen_string_literal: true

module Yardstick
  # Handles Yardstick configuration
  #
  class Config
    # Error raised when an invalid rule is provided
    class InvalidRule < StandardError
    end

    NAMESPACE_PREFIX = 'Yardstick::Rules::'

    # Set the threshold
    #
    # @return [undefined]
    #
    # @api public

    # Threshold value
    #
    # @return [Integer]
    #
    # @api private
    attr_accessor :threshold

    # Specify if the threshold should match the coverage
    #
    # @return [undefined]
    #
    # @api public
    attr_writer :require_exact_threshold

    # List of paths to measure
    #
    # @return [undefined]
    #
    # @api public

    # List of paths to measure
    #
    # @return [String]
    #
    # @api private
    attr_accessor :path

    # Specify if the coverage summary should be displayed
    #
    # @return [undefined]
    #
    # @api public
    attr_writer :verbose

    # The path to the file where the measurements will be written
    #
    # @return [Yardstick::ReportOutput]
    #
    # @api private
    attr_reader :output

    # Coerces hash into a config object
    #
    # @param [Hash] hash
    #
    # @yieldparam [Yardstick::Config] config
    #   the config object
    #
    # @return [Config]
    #
    # @api private
    def self.coerce(hash, &)
      new(normalize_hash(hash), &)
    end

    # Converts string keys into symbol keys
    #
    # @param [Hash] hash
    #
    # @return [Hash]
    #   normalized hash
    #
    # @api private
    def self.normalize_hash(hash)
      hash.reduce({}) do |normalized_hash, (key, value)|
        normalized_hash[key.to_sym] = if value.instance_of?(Hash)
          normalize_hash(value)
        else
          value
        end

        normalized_hash
      end
    end

    # Initializes new config
    #
    # @param [Hash] options
    #   optional configuration
    #
    # @yieldparam [Yardstick::Config] config
    #   the config object
    #
    # @return [Yardstick::Config]
    #
    # @api private
    def initialize(options = {})
      self.defaults = options

      yield(self) if block_given?
    end

    # Return config for given rule
    #
    # @param [Class] rule_class
    #
    # @return [RuleConfig]
    #
    # @api private
    def for_rule(rule_class)
      name = rule_class.to_s
      raise InvalidRule, "every rule must begin with #{NAMESPACE_PREFIX}" unless name.start_with?(NAMESPACE_PREFIX)

      RuleConfig.new(@rules.fetch(name.delete_prefix(NAMESPACE_PREFIX).to_sym, {}))
    end

    # Specify if the coverage summary should be displayed
    #
    # @return [Boolean]
    #
    # @api private
    def verbose?
      @verbose
    end

    # Return if the threshold should match the coverage
    #
    # @return [Boolean]
    #
    # @api private
    def require_exact_threshold?
      @require_exact_threshold
    end

    # The path to the file where the measurements will be written
    #
    # @param [String, Pathname] output
    #   optional output path for measurements
    #
    # @return [undefined]
    #
    # @api public
    def output=(output)
      @output = ReportOutput.coerce(output)
    end

    private

    # Sets default options
    #
    # @param [Hash] options
    #   optional configuration
    #
    # @return [undefined]
    #
    # @api private
    def defaults=(options)
      @threshold               = options.fetch(:threshold, 100)
      @verbose                 = options.fetch(:verbose, true)
      @path                    = options.fetch(:path, 'lib/**/*.rb')
      @require_exact_threshold = options.fetch(:require_exact_threshold, true)
      @rules                   = options.fetch(:rules, {})
      self.output              = 'measurements/report.txt'
    end

    class << self
      private :normalize_hash
    end
  end
end
