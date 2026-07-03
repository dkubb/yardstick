# frozen_string_literal: true

# Measure YARD documentation coverage
module Yardstick
  # Holds the attributes for a Decorator
  # @!attribute [r] color
  #   The resolved ANSI color code
  #   @api private
  #   @return [Integer]
  # @!attribute [r] mode
  #   The resolved ANSI mode code
  #   @api private
  #   @return [Integer]
  DecoratorData = Data.define(:color, :mode)
  private_constant :DecoratorData

  # A string decorator for applying unix console codes
  # @!attribute [r] color
  #   The resolved ANSI color code
  #   @api private
  #   @return [Integer]
  # @!attribute [r] mode
  #   The resolved ANSI mode code
  #   @api private
  #   @return [Integer]
  # @api public
  class Decorator < DecoratorData
    FORMAT = "\e[%<mode>d;%<color>dm%<string>s\e[0m"

    COLOR_CODES = {
      red: 31,
      yellow: 33
    }.freeze

    MODE_CODES = {
      bold: 1,
      underline: 4
    }.freeze

    private_constant :FORMAT, :COLOR_CODES, :MODE_CODES

    # Initializes new string decorator instance
    #
    # @param color [Symbol] name of color to use for formatting
    # @param mode [Symbol] mode for formatting text
    #
    # @return [undefined]
    #
    # @api private
    def initialize(color:, mode:)
      super(color: COLOR_CODES.fetch(color), mode: MODE_CODES.fetch(mode))
    end

    # Decorate a string
    #
    # @param string [String] unformatted string
    #
    # @return [String]
    #
    # @api private
    def decorate(string)
      FORMAT % { mode: mode, color: color, string: string }
    end

    NONE = Data.define { def decorate(string) = string }.new

    RED_BOLD          = new(color: :red,    mode: :bold)
    YELLOW_UNDERLINED = new(color: :yellow, mode: :underline)
  end
end
