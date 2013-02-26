# encoding: utf-8

module Yardstick

  # A measurement given a constraint on the docs
  class Measurement

    # Return the Measurement description
    #
    # @example
    #   measurement.description  # => "The description"
    #
    # @return [String]
    #   the description
    #
    # @api public
    attr_reader :description

    # Return the method docstring
    #
    # @return [YARD::Docstring]
    #
    # @api private
    attr_reader :docstring
    protected :docstring

    # Return a Measurement instance
    #
    # @example
    #   measurement = Measurement.new('The description', docstring, :successful_method)
    #
    # @param [#to_str] description
    #   the measurement description
    # @param [YARD::Docstring] docstring
    #   the docstring to measure
    #
    # @yield []
    #   the measurement to perform
    #
    # @return [Yardstick::Measurement]
    #   the measurement instance
    #
    # @api public
    def initialize(description, docstring, &block)
      @description = description.to_str
      @docstring   = docstring
      @block       = block
      @result      = measure
    end

    # Return true if the measurement was successful
    #
    # @example Measurement successful
    #   measurement.ok?  # => true
    #
    # @example Measurement unsuccessful
    #   measurement.ok?  # => false
    #
    # @return [Boolean]
    #   true if the measurement was successful, false if not
    #
    # @api public
    def ok?
      @result == true || skip?
    end

    # Return true if the measurement was skipped
    #
    # @example Measurement skipped
    #   measurement.skip?  # => true
    #
    # @example Measurement not skipped
    #   measurement.skip?  # => false
    #
    # @return [Boolean]
    #   true if the measurement was skipped, false if not
    #
    # @api public
    def skip?
      @result == :skip
    end

    # Return true if the measurement is not implemented
    #
    # @example Measurement not implemented
    #   measurement.todo?  # => true
    #
    # @example Measurement implemented
    #   measurement.todo?  # => false
    #
    # @return [Boolean]
    #   true if the measurement is not implemented, false if not
    #
    # @api public
    def todo?
      @result == :todo
    end

    # Warns the results the measurement if it was not successful
    #
    # @example
    #   measurement.puts  # (outputs results if not successful)
    #
    # @param [#puts] io
    #   optional object to puts the summary
    #
    # @return [undefined]
    #
    # @api public
    def puts(io = $stdout)
      unless ok?
        io.puts("#{file}:#{line}: #{path}: #{@description}")
      end
    end

    # Test if Measurement is equal to another measurement
    #
    # @example
    #   measurement == equal_measurement  # => true
    #
    # @param [Yardstick::Measurement] other
    #   the other Measurement
    #
    # @return [Boolean]
    #   true if the Measurement is equal to the other, false if not
    #
    # @api semipublic
    def eql?(other)
      other.kind_of?(self.class) &&
      description.eql?(other.description) &&
      docstring.eql?(other.docstring)
    end

    # Return hash identifier for the Measurement
    #
    # @return [Integer]
    #   the hash identifier
    #
    # @api private
    def hash
      @description.hash ^ @docstring.hash
    end

  private

    # Measure the docstring using the method provided to the constructor
    #
    # @return [Boolean, Symbol]
    #   true if the test is successful, false if not
    #   :todo if the test is not implemented
    #   :skip if the test does not apply
    #
    # @api private
    def measure
      catch :measurement do
        @docstring.instance_eval(&@block)
      end
    end

    # The code object for the docstring
    #
    # @return [YARD::CodeObjects::Base]
    #   the code object
    #
    # @api private
    def object
      @docstring.object
    end

    # The filename for the code
    #
    # @return [Pathname]
    #   the filename
    #
    # @api private
    def file
      Pathname(object.file)
    end

    # The line number for the code
    #
    # @return [Integer]
    #   the line number
    #
    # @api private
    def line
      object.line
    end

    # The class and method name for the code
    #
    # @return [String]
    #   the class and method name
    #
    # @api private
    def path
      object.path
    end

    module UtilityMethods  #:nodoc:
      private

      # Throw a :skip measurement message to the caller
      #
      # This method allows you to short-circuit measurement methods when
      # the measurement does not apply due to specific object states.
      #
      # @return [undefined]
      #
      # @api private
      def skip
        throw :measurement, :skip
      end

      # Throw a :todo measurement message to the caller
      #
      # This method allows you to short-circuit measurement methods when
      # the measurement is not implemented.
      #
      # @return [undefined]
      #
      # @api private
      def todo
        throw :measurement, :todo
      end

    end # module UtilityMethods

  end # class Measurement
end # module Yardstick
