require 'rational'

module Yardstick
  class MeasurementSet < OrderedSet

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
      size
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
