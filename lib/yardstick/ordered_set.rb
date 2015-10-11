# encoding: utf-8

module Yardstick
  # A base class for an ordered set
  class OrderedSet
    include Concord.new(:entries, :index), Enumerable

    # Returns the OrderedSet instance
    #
    # @param [Array] entries
    #   optional entries
    #
    # @return [Yardstick::OrderedSet]
    #   the ordered set instance
    #
    # @api private
    def initialize(entries = nil)
      super([], {})

      merge(entries) if entries
    end

    # Append to the OrderedSet
    #
    # @param [Object] entry
    #   the object to append
    #
    # @return [Yardstick::OrderedSet]
    #   returns self
    #
    # @api private
    def <<(entry)
      unless include?(entry)
        @index[entry] = length
        entries << entry
      end
      self
    end

    # Merge in another OrderedSet
    #
    # @param [#each] other
    #   the other ordered set
    #
    # @return [Yardstick::OrderedSet]
    #   returns self
    #
    # @api private
    def merge(other)
      other.each { |entry| self << entry }
      self
    end

    # Iterate over each entry
    #
    # @yield [entry]
    #   yield to the entry
    #
    # @yieldparam [Object] entry
    #   an entry in the ordered set
    #
    # @return [Yardstick::OrderedSet]
    #   returns self
    #
    # @api private
    def each(&block)
      entries.each(&block)
      self
    end

    # Check if there are any entries
    #
    # @return [Boolean]
    #   true if there are no entries, false if there are
    #
    # @api private
    def empty?
      entries.empty?
    end

    # The number of entries
    #
    # @return [Integer]
    #   number of entries
    #
    # @api private
    def length
      entries.length
    end

    # Check if the entry exists in the set
    #
    # @param [Object] entry
    #   the entry to test for
    #
    # @return [Boolean]
    #   true if the entry exists in the set, false if not
    #
    # @api private
    def include?(entry)
      @index.key?(entry)
    end

    # Return the index for the entry in the set
    #
    # @param [Object] entry
    #   the entry to check the set for
    #
    # @return [Integer, nil]
    #   the index for the entry, or nil if it does not exist
    #
    # @api private
    def index(entry)
      @index[entry]
    end
  end # class OrderedSet
end # module Yardstick
