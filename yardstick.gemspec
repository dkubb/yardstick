# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'yardstick/version'

Gem::Specification.new do |gem|
  gem.name        = 'yardstick'
  gem.version     = Yardstick::VERSION.dup
  gem.authors     = ['Dan Kubb']
  gem.email       = %w[dan.kubb@gmail.com]
  gem.description = 'Measure YARD documentation coverage'
  gem.summary     = 'A tool for verifying YARD documentation coverage'
  gem.homepage    = 'https://github.com/dkubb/yardstick'
  gem.licenses    = %w[MIT]

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files -- spec/{public,semipublic}`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.md]
  gem.executables      = %w[yardstick]

  gem.add_runtime_dependency('backports', '~> 3.3', '>= 3.3.0')
  gem.add_runtime_dependency('yard',      '~> 0.8', '>= 0.8.6')

  gem.add_development_dependency('bundler', '~> 1.3', '>= 1.3.5')
end
