module YARD  #:nodoc: all

  # Extend docstring with yardstick methods
  class Docstring
    include Yardstick::Method
  end # class Docstring
end # module YARD
