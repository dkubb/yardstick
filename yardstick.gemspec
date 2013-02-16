# encoding: utf-8

require File.expand_path('../lib/yardstick/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'yardstick'
  gem.version     = Yardstick::VERSION.dup
  gem.authors     = ['Dan Kubb']
  gem.email       = %w[dan.kubb@gmail.com]
  gem.description = 'Measure YARD documentation coverage'
  gem.summary     = 'A tool for verifying YARD documentation coverage'
  gem.homepage    = 'https://github.com/dkubb/yardstick'

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files -- spec/{public,semipublic}`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.rdoc]
  gem.executables      = %w[yardstick]

  gem.add_runtime_dependency('backports', '~> 2.8.2')
  gem.add_runtime_dependency('yard',      '~> 0.8.4.1')

  gem.add_development_dependency('rake',  '~> 10.0.3')
  gem.add_development_dependency('rspec', '~> 1.3.2')
end
