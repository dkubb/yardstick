require Pathname(__FILE__).dirname.expand_path.join('..', 'lib', 'yardstick')

# yardstick_measure task
Yardstick::Rake::Measurement.new

# verify_measurements task
Yardstick::Rake::Verify.new do |verify|
  verify.threshold = 100
end
