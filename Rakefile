require 'rubygems'
require 'rake'
require 'pathname'

begin
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name              = 'yardstick'
    gem.summary           = 'A tool for verifying YARD documentation coverage'
    gem.email             = 'dan.kubb@gmail.com'
    gem.homepage          = 'http://github.com/dkubb/yardstick'
    gem.authors           = [ 'Dan Kubb' ]
    gem.rubyforge_project = 'yardstick'

    gem.add_dependency 'yard', '~> 0.5.8'

    gem.add_development_dependency 'flay',      '~> 1.4.0'
    gem.add_development_dependency 'flog',      '~> 2.4.0'
    gem.add_development_dependency 'metric_fu', '~> 1.5.1'
    gem.add_development_dependency 'reek',      '~> 1.2.8'
    gem.add_development_dependency 'roodi',     '~> 2.1.0'
    gem.add_development_dependency 'rspec',     '~> 1.3'
  end

  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.remote_doc_path = ''
  end

  Pathname.glob('tasks/**/*.rake').each { |task| load task.expand_path }
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler'
end
