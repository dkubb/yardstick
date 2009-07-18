require 'rake/rdoctask'

Rake::RDocTask.new do |rdoc|
  version = if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    ''
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "yardstick #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
