require 'rubygems'
require 'spec'
require 'pathname'

dir = Pathname(__FILE__).dirname.expand_path.join('..', 'lib')

require dir + 'yardstick'

Pathname.glob(dir.join('**', '*.rb')).sort.each do |file|
  require file.to_s.chomp('.rb')
end

Spec::Runner.configure do |config|
  config.before do
    YARD::Registry.clear
  end
end
