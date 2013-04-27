# encoding: utf-8

require 'rake'
require 'rake/tasklib'

require 'pathname'
require 'yardstick'

module Yardstick
  module Rake

    # A rake task for measuring docs in a set of files
    class Measurement < ::Rake::TaskLib

      # Initializes a Measurement task
      #
      # @example
      #   task = Yardstick::Rake::Measurement
      #
      # @param [Symbol] name
      #   optional task name
      #
      # @yieldparam [Yardstick::Config] config
      #   the config object
      #
      # @return [Yardstick::Rake::Measurement]
      #   the measurement task
      #
      # @api public
      def initialize(options = {}, name = :yardstick_measure, &block)
        @name   = name
        @config = Config.coerce(options, &block)

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
        write_report { |io| Yardstick.measure(@config).puts(io) }
      end

    private

      # Define the task
      #
      # @return [undefined]
      #
      # @api private
      def define
        desc "Measure docs in #{@config.path} with yardstick"
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
        @config.output.write(&block)
      end

    end # class Measurement
  end # module Rake
end # module Yardstick
