require 'rubygems'
require 'spec'
require 'pathname'

require Pathname(__FILE__).dirname.expand_path.join('..', 'lib', 'yardstick')

Spec::Runner.configure do |config|
end
