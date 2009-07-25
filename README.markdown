Yardstick 0.1.0
===============

Synopsis
--------

Yardstick is a tool that verifies YARD coverage of ruby code.

It will measure the source and provide feedback on what is missing from
the documentation and what can be improved.

Installation
------------

From Gem:

    $ sudo gem install dkubb-yardstick --source http://gems.github.com/

With a local working copy:

    $ git clone git://github.com/dkubb/yardstick.git
    $ cd yardstick
    $ rake build && sudo rake install

Usage
-----

Yardstick may be used two ways:

**1. yardstick Command-line Tool**

This is the simplest way to run yardstick.  Provide it a list of files
and it will measure all of them and output suggestions for improvement,
eg:

    $ yardstick lib/**/*.rb

**2. Yardstick Libraries**

Yardstick comes with several libraries that will allow you to process
lists of files, or String code fragments, eg:

    # measure a list of file paths
    measurements = Yardstick.measure(paths)

    # measure a code fragment
    measurements = Yardstick.measure_string <<-RUBY
      # Displays the message provided to stdout
      #
      # @param [#to_str] message
      #   the message to display
      #
      # @return [undefined]
      #
      # @api public
      def display(message)
        puts message.to_str
      end
    RUBY

TODO
----

- Add more measurements, especially for @param, @yield and type
  validation
- Create a Rake task to allow integration of Yardstick into build
  processes more easily

Copyright (c) 2009 Dan Kubb. See LICENSE for details.
