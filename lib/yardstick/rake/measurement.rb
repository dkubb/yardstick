# encoding: utf-8

require 'rake'
require 'rake/tasklib'

require 'pathname'
require 'yardstick'

module Yardstick
  module Rake
    # A rake task for measuring docs in a set of files
    class Measurement < ::Rake::TaskLib
      include Concord.new(:name, :config)

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
      def initialize(name = :yardstick_measure, options = {}, &block)
        super(name, Config.coerce(options, &block))

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
        config.output.write { |io| Yardstick.measure(config).puts(io) }
      end

      private

      # Define the task
      #
      # @return [undefined]
      #
      # @api private
      def define
        desc "Measure docs in #{config.path} with yardstick"
        task(name) { yardstick_measure }
      end
    end # class Measurement
  end # module Rake
end # module Yardstick
