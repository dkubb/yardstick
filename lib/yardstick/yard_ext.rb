# encoding: utf-8

module YARD  #:nodoc: all

  # Test if JRuby head is being used
  JRUBY        = RUBY_ENGINE == 'jruby'
  JRUBY_HEAD   = JRUBY && JRUBY_VERSION >= '1.7.4.dev'
  JRUBY_19MODE = JRUBY && RUBY_VERSION  >= '1.9'

  # Fix jruby-head to use the ruby 1.8 parser until their ripper port is working
  Parser::SourceParser.parser_type = :ruby18 if JRUBY_HEAD && JRUBY_19MODE

  # Extend docstring with yardstick methods
  class Docstring
    include Yardstick::Method
  end # class Docstring
end # module YARD
