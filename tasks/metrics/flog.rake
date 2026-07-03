# frozen_string_literal: true

require 'yaml'
require 'flog'

namespace :metrics do
  desc 'Analyze code complexity with flog'
  task :flog do
    flog_options = YAML.safe_load_file('config/flog.yml')
    threshold    = flog_options.fetch('threshold', 10)
    flog         = Flog.new(continue: true)
    flog.flog(*Flog.expand_dirs_to_files('lib'))

    average = flog.average

    raise "Flog average #{average.round(1)} exceeds threshold #{threshold}" unless average <= threshold

    puts "Passed flog (average: #{average.round(1)}, threshold: #{threshold})"
  end
end
