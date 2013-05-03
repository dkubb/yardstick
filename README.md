yardstick
=========

[![Gem Version](https://badge.fury.io/rb/yardstick.png)][gem]
[![Build Status](https://secure.travis-ci.org/dkubb/yardstick.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/dkubb/yardstick.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/dkubb/yardstick.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/dkubb/yardstick/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/yardstick
[travis]: https://travis-ci.org/dkubb/yardstick
[gemnasium]: https://gemnasium.com/dkubb/yardstick
[codeclimate]: https://codeclimate.com/github/dkubb/yardstick
[coveralls]: https://coveralls.io/r/dkubb/yardstick

Yardstick is a tool that verifies documentation coverage of Ruby code.  It will measure the source and provide feedback on what is missing from the documentation and what can be improved.

* [Git](https://github.com/dkubb/yardstick)
* [Bug Tracker](https://github.com/dkubb/yardstick/issues)

Installation
------------

With Rubygems:

```bash
$ gem install yardstick
$ irb -rubygems
>> require 'yardstick'
=> true
```

With git and local working copy:

```bash
$ git clone git://github.com/dkubb/yardstick.git
$ cd yardstick
$ rake install
$ irb -rubygems
>> require 'yardstick'
=> true
```

Usage
-----

Yardstick may be used three ways:

### 1. Command-line Tool

This is the simplest way to run yardstick.  Provide it a list of files
and it will measure all of them and output suggestions for improvement,
eg:

```
$ yardstick 'lib/**/*.rb' 'app/**/*.rb' ...etc...
```

### 2. Rake task

Yardstick may be integrated with existing Rakefile and build processes,
and is especially useful when used with a continuous integration system.
You can set thresholds, as well as check that the threshold matches the
actual coverage, forcing you to bump it up if the actual coverage has
increased.  It uses a simple DSL to configure the task eg:

```
# measure coverage

require 'yardstick/rake/measurement'

Yardstick::Rake::Measurement.new(:yardstick_measure) do |measurement|
  measurement.output = 'measurement/report.txt'
end


# verify coverage

require 'yardstick/rake/verify'

Yardstick::Rake::Verify.new do |verify|
  verify.threshold = 100
end
```

### 3. Libraries

Yardstick comes with several libraries that will allow you to process
lists of files, or String code fragments, eg:

```
require 'yardstick'

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
```

TODO
----

* Add more measurements, especially for @param, @yield and type
  validation
* Update yardstick_measure task to use the Yardstick::CLI library
  underneath.
* Output results as HTML from command line tool and Rake task
* Specify method_missing to allow public, semipublic or private even
  if its visibility is private
* Allow initialize to be public, semipublic or private regardless of
  its visibility. A constructor may not necessarily be public, and may
  not be used externally.

Copyright (c) 2009-2013 Dan Kubb. See LICENSE for details.
