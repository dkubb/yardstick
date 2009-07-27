require Pathname(__FILE__).dirname.expand_path.join('..', 'lib', 'yardstick')

Yardstick::Rake::Verify.new do |verify|
  verify.threshold = 100
end
