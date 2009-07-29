require 'rake'
require 'rake/tasklib'

module Yardstick
  module Rake
    class Verify < ::Rake::TaskLib

      # Set the threshold
      #
      # @param [Number] threshold
      #   the threshold to set
      #
      # @return [undefined]
      #
      # @api public
      attr_writer :threshold

      # Specify if the threshold should match the coverage
      #
      # @param [Boolean] require_exact_threshold
      #   true if the threshold should match the coverage, false if not
      #
      # @return [undefined]
      #
      # @api public
      attr_writer :require_exact_threshold

      # List of paths to measure
      #
      # @param [Array<#to_s>, #to_s] path
      #   optional list of paths to measure
      #
      # @return [undefined]
      #
      # @api public
      attr_writer :path

      # Specify if the coverage summary should be displayed
      #
      # @param [Boolean] verbose
      #   true if the coverage summary should be displayed, false if not
      #
      # @return [undefined]
      #
      # @api public
      attr_writer :verbose

      # Initialize a Verify task
      #
      # @example
      #   task = Yardstick::Rake::Verify.new do |task|
      #     task.threshold = 100
      #   end
      #
      # @param [Symbol] name
      #   optional task name
      #
      # @yield [task]
      #   yield to self
      #
      # @yieldparam [Yardstick::Rake::Verify] task
      #   the verification task
      #
      # @return [Yardstick::Rake::Verify] task
      #   the verification task instance
      #
      # @api public
      def initialize(name = :verify_measurements)
        @name                    = name
        @require_exact_threshold = true
        @path                    = 'lib/**/*.rb'
        @verbose                 = true

        yield self

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
        puts "Coverage: #{total_coverage}% (threshold: #{@threshold}%)" if verbose
        assert_meets_threshold
        assert_matches_threshold
      end

    private

      # Define the task
      #
      # @return [undefined]
      #
      # @api private
      def define
        desc "Verify that yardstick coverage is at least #{@threshold}%"
        task(@name) { verify_measurements }
      end

      # The total YARD coverage
      #
      # @return [Float]
      #   the total coverage
      #
      # @api private
      def total_coverage
        measurements = Yardstick.measure(@path)
        round_percentage(measurements.coverage * 100)
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
      def round_percentage(percentage)
        (percentage * 10).ceil / 10.0
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
        if @threshold.nil?
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
        if total_coverage < @threshold
          raise "Coverage must be at least #{@threshold}% but was #{total_coverage}%"
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
        if @require_exact_threshold && total_coverage > @threshold
          raise "Coverage has increased above the threshold of #{@threshold}% to #{total_coverage}%. You should update your threshold value."
        end
      end

    end # class Verify
  end # module Rake
end # module Yardstick
