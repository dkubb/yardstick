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
    def self.coerce(hash, &block)
      new(normalize_hash(hash), &block)
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
    # @yieldparam [Yardstick::Config] config
    #   the config object
    #
    # @return [Yardstick::Config]
    #
    # @api private
    def initialize(options = {}, &block)
      @options = options
      @rules   = @options.fetch(:rules, {})

      set_defaults

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
    # @return [undefined]
    #
    # @api private
    def set_defaults
      @threshold               = @options[:threshold]
      @verbose                 = true
      @path                    = @options[:path] || 'lib/**/*.rb'
      @require_exact_threshold = true
      self.output              = 'measurements/report.txt'
    end

    class << self
      private :normalize_hash
    end
  end
end
