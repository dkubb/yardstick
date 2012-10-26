require 'rake'

require File.expand_path('../lib/yardstick/version', __FILE__)

FileList['tasks/**/*.rake'].each { |task| import task }

task :default => :spec
