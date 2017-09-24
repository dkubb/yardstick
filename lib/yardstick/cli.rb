# encoding: utf-8

require 'optparse'

module Yardstick
  # Handle the yardstick command line interface
  class CLI
    # Parse the command line options, and run the command
    #
    # @example
    #   Yardstick::CLI.run(*%w[ article.rb ])  # => [ Measurement ]
    #
    # @param [Array] args
    #   arguments passed in from the command line
    #
    # @return [Yardstick::MeasurementSet]
    #   the measurement for each file
    #
    # @api public
    def self.run(*args)
      measurements = Yardstick.measure(parse_config(args))
      measurements.puts
      measurements
    end

    # Parse the options provided from the command-line
    #
    # @param [Array<String>] args
    #   the command-line options
    #
    # @return [Config]
    #   the list of files, and options parsed from the command-line
    #
    # @api private
    def self.parse_config(args)
      options = {}
      option_parser.parse!(args, into: options)

      overrides = {}
      overrides[:path] = args if args.any?

      if options[:config]
        Config.from_file(options[:config], overrides)
      else
        Config.coerce(overrides)
      end
    rescue OptionParser::InvalidOption => error
      display_exit(error)
    end

    # Return an OptionParser instance for the command-line app
    #
    # @return [Yardstick::OptionParser]
    #   the option parser instance
    #
    # @api private
    def self.option_parser
      @option_parser ||= OptionParser.new do |opts|
        opts.on('-c FILE', '--config FILE', "load config file (default #{Yardstick::Config::DEFAULT_CONFIG_FILE})") do |file|
          if File.exist?(file)
            Pathname(file)
          else
            display_exit("Config file not found: #{file}")
          end
        end

        opts.on_tail('-v', '--version', 'print version information and exit') { display_exit("#{opts.program_name} #{VERSION}") }
        opts.on_tail('-h', '--help',    'display this help and exit')         { display_exit(opts) }
      end
    end

    # Display a message and exit
    #
    # @param [#to_str] message
    #   the message to display
    #
    # @return [undefined]
    #
    # @api private
    def self.display_exit(message)
      puts message
      exit
    end

    class << self
      private :option_parser, :parse_config, :display_exit
    end
  end # module CLI
end # module Yardstick
