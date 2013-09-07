# encoding: utf-8

module Yardstick

  # Handles writing reports
  class ReportOutput

    # Coerces string path into proper output object
    #
    # @param [String, Pathname] target
    #   path of the output
    #
    # @return [Yardstick::ReportOutput]
    #
    # @api private
    def self.coerce(target)
      new(Pathname(target))
    end

    # Initializes ReportOutput instance
    #
    # @param [Pathname] target
    #
    # @return [undefined]
    #
    # @api private
    def initialize(target)
      @target = target
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
    def write(&block)
      @target.dirname.mkpath
      @target.open('w', &block)
    end

    # @see [Pathname#to_s]
    #
    # @return [String]
    #
    # @api private
    def to_s
      @target.to_s
    end

  end
end
