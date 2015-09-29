# encoding: utf-8

module YARD  #:nodoc: all
  # Test if JRuby head is being used
  JRUBY_19MODE = RUBY_VERSION >= '1.9' && RUBY_ENGINE.eql?('jruby')

  # Fix jruby-head to use the ruby 1.8 parser until their ripper port is working
  Parser::SourceParser.parser_type = :ruby18 if JRUBY_19MODE
end # module YARD
