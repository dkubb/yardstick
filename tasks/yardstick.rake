require File.expand_path('../../lib/yardstick', __FILE__)

# yardstick_measure task
Yardstick::Rake::Measurement.new

# verify_measurements task
Yardstick::Rake::Verify.new do |verify|
  verify.threshold = 100
end
