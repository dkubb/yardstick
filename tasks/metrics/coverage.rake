# frozen_string_literal: true

namespace :metrics do
  desc 'Run full spec suite with coverage enforcement (minimum 100%)'
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task[:spec].invoke
  end
end

CLEAN << 'coverage'
