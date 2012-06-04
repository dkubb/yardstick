require 'rake'
require 'rake/tasklib'

require 'pathname'
require 'yardstick'

module Yardstick
  module Rake
    class Measurement < ::Rake::TaskLib

      # List of paths to measure
      #
      # @return [undefined]
      #
      # @api public
      attr_writer :path

      # The path to the file where the measurements will be written
      #
      # @param [String, Pathname] output
      #   optional output path for measurements
      #
      # @return [undefined]
      #
      # @api public
      def output=(output)
        @output = Pathname(output)
      end

      # Initializes a Measurement task
      #
      # @example
      #   task = Yardstick::Rake::Measurement
      #
      # @param [Symbol] name
      #   optional task name
      #
      # @yield [task]
      #   yield to self
      #
      # @yieldparam [Yardstick::Rake::Measurement] task
      #   the measurement task
      #
      # @return [Yardstick::Rake::Measurement]
      #   the measurement task
      #
      # @api public
      def initialize(name = :yardstick_measure)
        @name = name
        @path = 'lib/**/*.rb'

        self.output = 'measurements/report.txt'

        yield self if block_given?

        define
      end

      # Measure the documentation
      #
      # @example
      #   task.yardstick_measure  # (output measurement report)
      #
      # @return [undefined]
      #
      # @api public
      def yardstick_measure
        write_report { |io| Yardstick.measure(@path).puts(io) }
      end

    private

      # Define the task
      #
      # @return [undefined]
      #
      # @api private
      def define
        desc "Measure docs in #{@path} with yardstick"
        task(@name) { yardstick_measure }
      end

      # Open up a report for writing
      #
      # @yield [io]
      #   yield to an object that responds to #puts
      #
      # @yieldparam [#puts] io
      #   the object that responds to #puts
      #
      # @return [undefined]
      #
      # @api private
      def write_report(&block)
        @output.dirname.mkpath
        @output.open('w', &block)
      end

    end # class Measurement
  end # module Rake
end # module Yardstick
