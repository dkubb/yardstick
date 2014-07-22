# encoding: utf-8

module Yardstick
  # A set of yardstick measurements
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
      length
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
      select { |measurement| measurement.ok? }.length
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
    #   coverage = measurements.coverage  # => Rational(561, 570)
    #   '%.1f%%' % (coverage * 100)       # => "98.4%"
    #
    # @return [Integer, Rational]
    #   the coverage percentage
    #
    # @api public
    def coverage
      empty? ? 1 : Rational(successful, total)
    end

    # Warn the unsuccessful measurements and a summary
    #
    # @example
    #   measurements.puts  # (outputs measurements results and summary)
    #
    # @param [#puts] io
    #   optional object to puts the summary
    #
    # @return [undefined]
    #
    # @api public
    def puts(io = $stdout)
      each { |measurement| measurement.puts(io) }
      puts_summary(io)
    end

    private

    # Warn the summary of all measurements
    #
    # @param [#puts] io
    #   object to puts the summary
    #
    # @return [undefined]
    #
    # @api private
    def puts_summary(io)
      io.puts("\n#{[coverage_text, successful_text, failed_text, total_text].join('  ')}")
    end

    # The text for the coverage percentage to include in the summary
    #
    # @return [String]
    #   the coverage text
    #
    # @api private
    def coverage_text
      'YARD-Coverage: %.1f%%' % Yardstick.round_percentage(coverage * 100)
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
