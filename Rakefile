require 'rake'

begin
  gem('jeweler', '~> 1.6.0') if respond_to?(:gem, true)
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name        = 'yardstick'
    gem.summary     = 'A tool for verifying YARD documentation coverage'
    gem.description = 'Measure YARD documentation coverage'
    gem.email       = 'dan.kubb@gmail.com'
    gem.homepage    = 'http://github.com/dkubb/yardstick'
    gem.authors     = [ 'Dan Kubb' ]
  end

  Jeweler::GemcutterTasks.new

  FileList['tasks/**/*.rake'].each { |task| import task }
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler -v 1.6.0'
end
