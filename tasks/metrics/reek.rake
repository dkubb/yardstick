# frozen_string_literal: true

require 'reek/rake/task'

namespace :metrics do
  Reek::Rake::Task.new(:reek) do |t|
    t.config_file  = 'config/reek.yml'
    t.source_files = 'lib/**/*.rb'
  end
end
