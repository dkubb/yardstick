# frozen_string_literal: true

require 'rake/clean'

Dir.glob('tasks/**/*.rake').each { |r| load r }

task ci: %w[
  metrics:rubocop
  metrics:reek
  metrics:flay
  metrics:flog
  metrics:yardstick:verify
  metrics:coverage
]

task default: :spec

module Rake
  # Overload Rake::Task to add logging
  class Task
    # Store the original execute method
    alias original_execute execute

    # Override execute to add a print statement
    def execute(args = nil)
      # Only output the task name if it wasn't the only top-level task
      # rake default      # => output task name for each task called by the default task
      # rake rubocop      # => do not output the task name
      # rake rubocop yard # => output task name for rubocop and yard
      top_level_tasks = Rake.application.top_level_tasks
      box("rake #{name}") unless top_level_tasks.length == 1 && name == top_level_tasks[0]
      original_execute(args)
    end

    private

    def box(message)
      width = message.length + 2
      puts "┌#{'─' * width}┐"
      puts "│ #{message} │"
      puts "└#{'─' * width}┘"
    end
  end
end
