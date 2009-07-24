require 'rational'

module Yardstick
  class MeasurementSet
    include Enumerable

    # Returns the MeasurementSet instance
    #
    # @example
    #   measurements = Yardstick::MeasurementSet.new
    #
    # @param [Array<Measurement>] measurements
    #   optional measurements
    #
    # @return [MeasurementSet<Measurement>]
    #   the measurement set instance
    #
    # @api public
    def initialize(measurements = [])
      @measurements = measurements.dup
    end

    # Append a Measurement
    #
    # @example
    #   measurements << measurement
    #
    # @param [Measurement] measurement
    #   the measurement to append
    #
    # @return [MeasurementSet<Measurement>]
    #   returns self
    #
    # @api public
    def <<(measurement)
      @measurements << measurement unless @measurements.include?(measurement)
      self
    end

    # Merge in another MeasurementSet
    #
    # @example
    #   measurements.merge(other)  # => both Measurements combined
    #
    # @param [MeasurementSet] other
    #   the other measurement set
    #
    # @return [MeasurementSet<Measurement>]
    #   returns self
    #
    # @api public
    def merge(other)
      other.each { |measurement| self << measurement }
      self
    end

    # Iterate over each Measurement
    #
    # @example
    #   measurements.each do |measurement
    #     # ... do something with measurement ...
    #   end
    #
    # @yield [measurement]
    #   yield to the Measurement
    #
    # @yieldparam [Measurement] measurement
    #   a Measurement in the MeasurementSet
    #
    # @return [MeasurementSet<Measurement>]
    #   returns self
    #
    # @api public
    def each(&block)
      @measurements.each(&block)
      self
    end

    # Check if there are any measurements
    #
    # @example No Measurements
    #   measurements.empty?  # => true
    #
    # @example One or more Measurements
    #   measurements.empty?  # => false
    #
    # @return [Boolean]
    #   true if there are no measurements, false if there are
    #
    # @api public
    def empty?
      @measurements.empty?
    end

    # The total number of measurements
    #
    # @example
    #   measurements.total  # => 570
    #
    # @return [Integer]
    #   total measurements
    #
    # @api public
    def total
      @measurements.size
    end

    # The number of successful measurements
    #
    # @example
    #   measurements.successful  # => 561
    #
    # @return [Integer]
    #   successful measurements
    #
    # @api public
    def successful
      select { |measurement| measurement.ok? }.size
    end

    # The number of failed measurements
    #
    # @example
    #   measurements.failed  # => 9
    #
    # @return [Integer]
    #   failed measurements
    #
    # @api public
    def failed
      total - successful
    end

    # The percentage of successful measurements
    #
    # @example
    #   measurements.coverage  # => Rational(561, 570).to_f  # => 98.4%
    #
    # @return [Integer, Rational]
    #   the coverage percentage
    #
    # @api public
    def coverage
      empty? ? 0 : Rational(successful, total)
    end

    # Warn the unsuccessful measurements and a summary
    #
    # @example
    #   measurements.warn  # (outputs measurements results and summary)
    #
    # @return [undefined]
    #
    # @api public
    def warn
      each { |measurement| measurement.warn }
      warn_summary
    end

  private

    # Warn the summary of all measurements
    #
    # @return [undefined]
    #
    # @api private
    def warn_summary
      Kernel.warn("\n#{[ coverage_text, successful_text, failed_text, total_text ].join('  ')}")
    end

    # The text for the coverage percentage to include in the summary
    #
    # @return [String]
    #   the coverage text
    #
    # @api private
    def coverage_text
      'Coverage: %.1f%%' % (coverage * 100)
    end

    # The text for the successful measurements to include in the summary
    #
    # @return [String]
    #   the successful text
    #
    # @api private
    def successful_text
      'Success: %d' % successful
    end

    # The text for the failed measurements to include in the summary
    #
    # @return [String]
    #   the failed text
    #
    # @api private
    def failed_text
      'Failed: %d' % failed
    end

    # The text for the total measurements to include in the summary
    #
    # @return [String]
    #   the total text
    #
    # @api private
    def total_text
      'Total: %d' % total
    end

  end # class MeasurementSet
end # module Yardstick
