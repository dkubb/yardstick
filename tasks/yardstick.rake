$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'yardstick/rake/measurement'
require 'yardstick/rake/verify'

# yardstick_measure task
Yardstick::Rake::Measurement.new

# verify_measurements task
Yardstick::Rake::Verify.new do |verify|
  verify.threshold = 100
end
