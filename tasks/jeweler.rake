begin
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name        = 'yardstick'
    gem.summary     = 'A tool for verifying YARD documentation coverage'
    gem.description = 'Measure YARD documentation coverage'
    gem.email       = 'dan.kubb@gmail.com'
    gem.homepage    = 'http://github.com/dkubb/yardstick'
    gem.authors     = [ 'Dan Kubb' ]

    gem.version = Yardstick::VERSION
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end
