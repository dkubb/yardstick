require 'rubygems'
require 'spec'
require 'pathname'

dir = Pathname(__FILE__).dirname.expand_path

$LOAD_PATH.unshift(dir)
$LOAD_PATH.unshift(dir.parent + 'lib')

require 'yardstick'

Spec::Runner.configure do |config|
end
