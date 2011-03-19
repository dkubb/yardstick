require 'rubygems'
require 'rake'

begin
  gem 'jeweler', '~> 1.5.2'
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name     = 'yardstick'
    gem.summary  = 'A tool for verifying YARD documentation coverage'
    gem.email    = 'dan.kubb@gmail.com'
    gem.homepage = 'http://github.com/dkubb/yardstick'
    gem.authors  = [ 'Dan Kubb' ]
    gem.has_rdoc = 'yard'

    gem.rubyforge_project = 'yardstick'

    gem.add_dependency 'yard', '~> 0.6.5'

    gem.add_development_dependency 'flay',      '~> 1.4.2'
    gem.add_development_dependency 'flog',      '~> 2.5.1'
    gem.add_development_dependency 'metric_fu', '~> 2.1.1'
    gem.add_development_dependency 'reek',      '~> 1.2.8'
    gem.add_development_dependency 'roodi',     '~> 2.1.0'
    gem.add_development_dependency 'rspec',     '~> 1.3.1'
  end

  Jeweler::GemcutterTasks.new

  FileList['tasks/**/*.rake'].each { |task| import task }

rescue LoadError => e
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
  puts '-----------------------------------------------------------------------------'
  puts e.backtrace # Let's help by actually showing *which* dependency is missing
end
