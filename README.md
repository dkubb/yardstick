# yardstick

[![Gem Version](http://img.shields.io/gem/v/yardstick.svg)][gem]
[![Build status](https://img.shields.io/circleci/project/dkubb/yardstick.svg)][circle]
[![Dependency Status](http://img.shields.io/gemnasium/dkubb/yardstick.svg)][gemnasium]
[![Code Climate](http://img.shields.io/codeclimate/github/dkubb/yardstick.svg)][codeclimate]
[![Coverage Status](http://img.shields.io/coveralls/dkubb/yardstick.svg)][coveralls]

[gem]: https://rubygems.org/gems/yardstick
[circle]: https://circleci.com/gh/dkubb/yardstick
[gemnasium]: https://gemnasium.com/dkubb/yardstick
[codeclimate]: https://codeclimate.com/github/dkubb/yardstick
[coveralls]: https://coveralls.io/r/dkubb/yardstick

Yardstick is a tool that verifies documentation coverage of Ruby code.  It will measure the source and provide feedback on what is missing from the documentation and what can be improved.

* [Git](https://github.com/dkubb/yardstick)
* [Bug Tracker](https://github.com/dkubb/yardstick/issues)

## Usage

Yardstick may be used three ways:

### 1. Command-line Tool

This is the simplest way to run yardstick.  Provide it a list of files
and it will measure all of them and output suggestions for improvement,
eg:

```sh
$ yardstick 'lib/**/*.rb' 'app/**/*.rb' ...etc...
```

### 2. Rake task

Yardstick may be integrated with existing Rakefile and build processes,
and is especially useful when used with a continuous integration system.
You can set thresholds, as well as check that the threshold matches the
actual coverage, forcing you to bump it up if the actual coverage has
increased.  It uses a simple DSL to configure the task eg:

```ruby
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

```ruby
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

### 4. Configuration

Every rule in Yardstick can be turned off globally and locally. All rules are enabled and threshold is set to maximum by default (100%). If your documentation coverage is below or above this threshold then yardstick will exit with a nonzero status and print that fact.

Default configuration:
```yaml
---
threshold: 100
rules:
  ApiTag::Presence:
    enabled: true
    exclude: []
  ApiTag::Inclusion:
    enabled: true
    exclude: []
  ApiTag::ProtectedMethod:
    enabled: true
    exclude: []
  ApiTag::PrivateMethod:
    enabled: true
    exclude: []
  ExampleTag:
    enabled: true
    exclude: []
  ReturnTag:
    enabled: true
    exclude: []
  Summary::Presence:
    enabled: true
    exclude: []
  Summary::Length:
    enabled: true
    exclude: []
  Summary::Delimiter:
    enabled: true
    exclude: []
  Summary::SingleLine:
    enabled: true
    exclude: []
```

To disable a rule for some part of the code use:

```yaml
rules:
  ApiTag::Presence:
    enabled: true
    exclude:
      - Foo::Bar  # class or module
      - Foo#bar   # instance method
      - Foo.bar   # class method
```

Rake tasks take these options as a second argument:

```ruby
options = YAML.load_file('config/yardstick.yml')

Yardstick::Rake::Verify.new(:verify_measurements, options)
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## Copyright

Copyright (c) 2009-2013 Dan Kubb. See LICENSE for details.
