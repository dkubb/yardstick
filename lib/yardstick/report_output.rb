# encoding: utf-8

module Yardstick
  # Handles writing reports
  class ReportOutput
    include Concord.new(:target)

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
      target.dirname.mkpath
      target.open('w', &block)
    end

    # @see [Pathname#to_s]
    #
    # @return [String]
    #
    # @api private
    def to_s
      target.to_s
    end
  end
end
