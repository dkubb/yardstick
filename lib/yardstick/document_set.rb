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
      reduce(MeasurementSet.new) do |set, document|
        set.merge(Document.measure(document, config))
        set
      end
    end

  end
end
