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

    gem.add_dependency 'yard', '~>0.4.0'

    gem.add_development_dependency 'flay',               '~> 1.4.0'
    gem.add_development_dependency 'flog',               '~> 2.2.0'
    gem.add_development_dependency 'gruff',              '~> 0.3.6'
    gem.add_development_dependency 'jscruggs-metric_fu', '~> 1.1.5'  # gem install jscruggs-metric_fu --source http://gems.github.com
    gem.add_development_dependency 'reek',               '~> 1.2.6'
    gem.add_development_dependency 'roodi',              '~> 2.0.1'
    gem.add_development_dependency 'rspec',              '~> 1.2.9'
    gem.add_development_dependency 'rmagick',            '~> 2.12.2'
  end

  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.remote_doc_path = ''
  end

  Pathname.glob('tasks/**/*.rake').each { |task| load task.expand_path }
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler'
end
