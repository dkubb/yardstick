module Yardstick
  autoload :CLI,            'yardstick/cli'
  autoload :Measurable,     'yardstick/measurable'
  autoload :Measurement,    'yardstick/measurement'
  autoload :MeasurementSet, 'yardstick/measurement_set'
  autoload :Method,         'yardstick/method'
  autoload :OrderedSet,     'yardstick/ordered_set'
  autoload :Processor,      'yardstick/processor'
  autoload :Rule,           'yardstick/rule'
  autoload :RuleSet,        'yardstick/rule_set'

  module Rake
    autoload :Measurement, 'yardstick/rake/measurement'
    autoload :Verify,      'yardstick/rake/verify'
  end # module Rake
end # module Yardstick
