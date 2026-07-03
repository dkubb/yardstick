# frozen_string_literal: true

require 'yaml'
require 'flay'
require 'flay_task'

namespace :metrics do
  flay_options = YAML.safe_load_file('config/flay.yml')

  FlayTask.new(:flay) do |t|
    t.dirs      = ['lib']
    t.threshold = flay_options.fetch('threshold', 0)
  end
end
