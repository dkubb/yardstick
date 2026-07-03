# frozen_string_literal: true

require 'English'

desc 'Build and install the yardstick gem and run a sanity check'
task 'test:gem': :install do
  output = `ruby -e "require 'yardstick'; puts Yardstick::VERSION"`.chomp
  raise 'Gem test failed' unless $CHILD_STATUS.success?
  raise "Expected gem test to return a version string, got: #{output.inspect}" unless Gem::Version.correct?(output)

  puts 'Gem Test Succeeded'
end
