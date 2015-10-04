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
  gem.licenses    = 'MIT'

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- spec/{unit,integration}`.split("\n")
  gem.extra_rdoc_files = %w[LICENSE README.md CONTRIBUTING.md TODO]
  gem.executables      = %w[yardstick]

  gem.add_runtime_dependency('yard', '~> 0.8', '>= 0.8.7.2')
  gem.add_runtime_dependency('concord', '~> 0.1.x')

  gem.add_development_dependency('bundler', '~> 1.6', '>= 1.6.1')
end
