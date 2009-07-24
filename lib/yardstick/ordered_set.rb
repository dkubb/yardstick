module Yardstick
  class OrderedSet
    include Enumerable

    # Returns the OrderedSet instance
    #
    # @param [Array] entries
    #   optional entries
    #
    # @return [OrderedSet]
    #   the ordered set instance
    #
    # @api private
    def initialize(entries = [])
      @entries = entries.dup
    end

    # Append to the OrderedSet
    #
    # @param [Object] entry
    #   the object to append
    #
    # @return [OrderedSet]
    #   returns self
    #
    # @api private
    def <<(entry)
      @entries << entry unless @entries.include?(entry)
      self
    end

    # Merge in another OrderedSet
    #
    # @param [OrderedSet] other
    #   the other ordered set
    #
    # @return [OrderedSet]
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
    # @return [OrderedSet]
    #   returns self
    #
    # @api private
    def each(&block)
      @entries.each(&block)
      self
    end

    # Check if there are any entries
    #
    # @return [Boolean]
    #   true if there are no entries, false if there are
    #
    # @api private
    def empty?
      @entries.empty?
    end

    # The number of entries
    #
    # @return [Integer]
    #   number of entries
    #
    # @api private
    def size
      @entries.size
    end

  end # class OrderedSet
end # module Yardstick
