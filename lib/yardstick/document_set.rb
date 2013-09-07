# encoding: utf-8

module Yardstick

  # A set of yardstick documents
  class DocumentSet < OrderedSet

    # Measure documents using given config
    #
    # @return [Yardstick::MeasurementSet]
    #   a collection of measurements
    #
    # @api private
    def measure(config)
      each_with_object(MeasurementSet.new) do |document, set|
        set.merge(Document.measure(document, config))
      end
    end

  end
end
