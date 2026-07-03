# frozen_string_literal: true

require 'yaml'

namespace :metrics do
  # metrics:mutant is intentionally excluded from the ci task —
  # mutation testing is slow and should be run separately as needed.
  desc 'Run mutation testing with mutant'
  task :mutant do
    mutant_options    = YAML.safe_load_file('config/mutant.yml')
    namespace_subject = mutant_options.fetch('namespace', 'Yardstick')
    gem_name          = mutant_options.fetch('name', 'yardstick')
    args = %W[
      mutant run
      --include lib
      --require #{gem_name}
      --use rspec
      --usage opensource
      #{namespace_subject}
    ]
    sh(*args)
  end
end
