require 'rubygems'
require 'spec'
require 'pathname'

require Pathname(__FILE__).dirname.expand_path.join('..', 'lib', 'yardstick')

Pathname.glob(Yardstick::ROOT.join('lib', '**', '*.rb')).sort.each do |file|
  require file.to_s.chomp('.rb')
end

Spec::Runner.configure do |config|
  config.before do
    YARD::Registry.clear
  end
end
