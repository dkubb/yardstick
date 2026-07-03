# frozen_string_literal: true

require 'rubocop/rake_task'

namespace :metrics do
  RuboCop::RakeTask.new(:rubocop) do |t|
    t.options = ['--config', 'config/rubocop.yml']
  end
end
