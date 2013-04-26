# encoding: utf-8

require 'rake'
require 'rake/tasklib'

require 'yardstick'

module Yardstick
  module Rake

    # A rake task for verifying the doc thresholds
    class Verify < ::Rake::TaskLib

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
      # @yield [task]
      #   yield to Config
      #
      # @yieldparam [Yardstick::Rake::Verify] task
      #   the verification task
      #
      # @return [Yardstick::Rake::Verify] task
      #   the verification task instance
      #
      # @api public
      def initialize(options = {}, name = :verify_measurements, &block)
        @name   = name
        @config = Config.new(options, &block)

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
        puts "YARD-Coverage: #{total_coverage}% (threshold: #{@config.threshold}%)" if @config.verbose?
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
        measurements = Yardstick.measure(@config.path, @config)
        self.class.round_percentage(measurements.coverage * 100)
      end

    private

      # Define the task
      #
      # @return [undefined]
      #
      # @api private
      def define
        desc "Verify that yardstick coverage is at least #{@config.threshold}%"
        task(@name) { verify_measurements }
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
        unless @config.threshold
          raise 'threshold must be set'
        end
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
        total_coverage = self.total_coverage
        threshold = @config.threshold

        if total_coverage < threshold
          raise "YARD-Coverage must be at least #{threshold}% but was #{total_coverage}%"
        end
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
        total_coverage = self.total_coverage
        threshold = @config.threshold

        if @config.require_exact_threshold? && total_coverage > threshold
          raise "YARD-Coverage has increased above the threshold of #{threshold}% to #{total_coverage}%. You should update your threshold value."
        end
      end

      # Round percentage to 1/10th of a percent
      #
      # @param [Float] percentage
      #   the percentage to round
      #
      # @return [Float]
      #   the rounded percentage
      #
      # @api private
      def self.round_percentage(percentage)
        (percentage * 10).ceil / 10.0
      end

    end # class Verify
  end # module Rake
end # module Yardstick
