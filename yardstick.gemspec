# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{yardstick}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Kubb"]
  s.date = %q{2009-07-23}
  s.default_executable = %q{yardstick}
  s.email = %q{dan.kubb@gmail.com}
  s.executables = ["yardstick"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "bin/yardstick",
     "lib/yardstick.rb",
     "lib/yardstick/autoload.rb",
     "lib/yardstick/cli.rb",
     "lib/yardstick/core_ext/object.rb",
     "lib/yardstick/measurable.rb",
     "lib/yardstick/measurement.rb",
     "lib/yardstick/method.rb",
     "lib/yardstick/processor.rb",
     "lib/yardstick/yard_ext.rb",
     "spec/public/yardstick/cli_spec.rb",
     "spec/public/yardstick/measurement_spec.rb",
     "spec/public/yardstick/method_spec.rb",
     "spec/public/yardstick_spec.rb",
     "spec/rcov.opts",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "tasks/ci.rake",
     "tasks/heckle.rake",
     "tasks/metrics.rake",
     "tasks/rdoc.rake",
     "tasks/spec.rake",
     "yardstick.gemspec"
  ]
  s.homepage = %q{http://github.com/dkubb/yardstick}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{yardstick}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A tool for verifying YARD documentation coverage}
  s.test_files = [
    "spec/public/yardstick/cli_spec.rb",
     "spec/public/yardstick/measurement_spec.rb",
     "spec/public/yardstick/method_spec.rb",
     "spec/public/yardstick_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<yard>, ["~> 0.2"])
    else
      s.add_dependency(%q<yard>, ["~> 0.2"])
    end
  else
    s.add_dependency(%q<yard>, ["~> 0.2"])
  end
end
