require 'rake'

include FileUtils

FileList['tasks/**/*.rake'].each { |task| import task }

task :default => :spec
