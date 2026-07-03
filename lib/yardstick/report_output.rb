# frozen_string_literal: true

# Measure YARD documentation coverage
module Yardstick
  # Holds the attributes for a ReportOutput
  # @!attribute [r] target
  #   The report output file path
  #   @api private
  #   @return [Pathname]
  ReportOutputData = Data.define(:target)
  private_constant :ReportOutputData

  # Handles writing reports
  class ReportOutput < ReportOutputData
    # Coerces string path into proper output object
    #
    # @param [String, Pathname] target
    #   path of the output
    #
    # @return [Yardstick::ReportOutput]
    #
    # @api private
    def self.coerce(target)
      new(target: Pathname(target))
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
    def write(&)
      target.dirname.mkpath
      target.open('w', &)
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
