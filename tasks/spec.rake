require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov    = true
end

RCov::VerifyTask.new(:verify_rcov) do |rcov|
  rcov.threshold = 84.49
end

task :default => :spec
