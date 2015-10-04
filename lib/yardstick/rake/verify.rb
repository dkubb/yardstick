# encoding: utf-8

require 'rake'
require 'rake/tasklib'

require 'yardstick'

module Yardstick
  module Rake
    # A rake task for verifying the doc thresholds
    class Verify < ::Rake::TaskLib
      include Concord.new(:name, :config, :threshold)

      # Initialize a Verify task
      #
      # @example
      #   task = Yardstick::Rake::Verify.new do |task|
      #     task.threshold = 100
      #   end
      #
      # @param [Hash] options
      #   optional configuration
      # @param [Symbol] name
      #   optional task name
      #
      # @yieldparam [Yardstick::Config] config
      #   the config object
      #
      # @return [Yardstick::Rake::Verify] task
      #   the verification task instance
      #
      # @api public
      def initialize(name = :verify_measurements, options = {}, &block)
        config = Config.coerce(options, &block)

        super(name, config, config.threshold)

        assert_threshold
        define
      end

      # Verify the YARD coverage measurements
      #
      # @example
      #   task.verify_measurements  # output coverage and threshold
      #
      # @return [undefined]
      #
      # @raise [RuntimeError]
      #   raised if threshold is not met
      # @raise [RuntimeError]
      #   raised if threshold is not equal to the coverage
      #
      # @api public
      def verify_measurements
        puts "YARD-Coverage: #{total_coverage}% (threshold: #{threshold}%)" if config.verbose?
        assert_meets_threshold
        assert_matches_threshold
      end

      protected

      # The total YARD coverage
      #
      # @return [Float]
      #   the total coverage
      #
      # @api private
      def total_coverage
        measurements = Yardstick.measure(config)
        Yardstick.round_percentage(measurements.coverage * 100)
      end

      private

      # Define the task
      #
      # @return [undefined]
      #
      # @api private
      def define
        modifier = config.require_exact_threshold? ? 'exactly' : 'at least'

        desc "Verify that yardstick coverage is #{modifier} #{threshold}%"
        task(name) { verify_measurements }
      end

      # Raise an exception if threshold is not set
      #
      # @return [undefined]
      #
      # @raise [RuntimeError]
      #   raised if threshold is not set
      #
      # @api private
      def assert_threshold
        return if threshold
        fail 'threshold must be set'
      end

      # Raise an exception if the threshold is not met
      #
      # @return [undefined]
      #
      # @raise [RuntimeError]
      #   raised if threshold is not met
      #
      # @api private
      def assert_meets_threshold
        return unless lower_coverage?
        fail "YARD-Coverage must be at least #{threshold}% but was #{total_coverage}%"
      end

      # Raise an exception if the threshold is not equal to the coverage
      #
      # @return [undefined]
      #
      # @raise [RuntimeError]
      #   raised if threshold is not equal to the coverage
      #
      # @api private
      def assert_matches_threshold
        return unless config.require_exact_threshold? && higher_coverage?
        fail "YARD-Coverage has increased above the threshold of #{threshold}% to #{total_coverage}%. You should update your threshold value."
      end

      # Checks if total coverage is lower than the threshold
      #
      # @return [Boolean]
      #   true if current coverage is lower
      #
      # @api private
      def lower_coverage?
        total_coverage < threshold
      end

      # Checks if total coverage is higher than the threshold
      #
      # @return [Boolean]
      #   true if current coverage is higher
      #
      # @api private
      def higher_coverage?
        total_coverage > threshold
      end
    end # class Verify
  end # module Rake
end # module Yardstick
