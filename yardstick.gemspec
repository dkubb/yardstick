# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'yardstick/version'

Gem::Specification.new do |spec|
  spec.author      = 'Dan Kubb'
  spec.email       = 'dan.kubb@gmail.com'
  spec.homepage    = 'https://github.com/dkubb/yardstick'
  spec.license     = 'MIT'
  spec.name        = 'yardstick'
  spec.summary     = 'Measure YARD documentation coverage'
  spec.description = <<~DESCRIPTION
    A tool for verifying YARD documentation coverage
  DESCRIPTION
  spec.version = Yardstick::VERSION

  spec.metadata['homepage_uri']          = spec.homepage
  spec.metadata['source_code_uri']       = spec.homepage
  spec.metadata['changelog_uri']         = "https://rubydoc.info/gems/#{spec.name}/#{spec.version}/file/CHANGELOG.md"
  spec.metadata['documentation_uri']     = "https://rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.3'

  spec.bindir      = 'exe'
  spec.executables = Dir['exe/*'].map { |f| File.basename(f) }

  spec.add_dependency 'yard', '~> 0.9'

  spec.add_development_dependency 'flay', '~> 2.14'
  spec.add_development_dependency 'flog', '~> 4.9'
  spec.add_development_dependency 'mutant-rspec', '~> 0.16'
  spec.add_development_dependency 'rake', '~> 13.4'
  spec.add_development_dependency 'reek', '~> 6.5'
  spec.add_development_dependency 'rspec', '~> 3.13'
  spec.add_development_dependency 'rspec-its', '~> 2.0'
  spec.add_development_dependency 'rubocop', '~> 1.88'
  spec.add_development_dependency 'simplecov', '~> 0.22'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(tests|spec|features)/}) }
  end
end
