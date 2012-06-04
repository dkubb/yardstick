source :rubygems

gem 'yard', '~> 0.8.1'

group :development do
  gem 'jeweler', '~> 1.8.3'
  gem 'rake',    '~> 0.9.2.2'
  gem 'rspec',   '~> 1.3.2'
end

group :jruby do
  platform :jruby do
    gem 'jruby-openssl', '~> 0.7.4'
  end
end

platforms :mri_18 do
  group :quality do
    gem 'flay',      '~> 1.4.2'
    gem 'flog',      '~> 2.5.1'
    gem 'heckle',    '~> 1.4.3'
    gem 'json',      '~> 1.7.3'
    gem 'metric_fu', '~> 2.1.1'
    gem 'mspec',     '~> 1.5.17'
    gem 'rcov',      '~> 1.0.0'
    gem 'reek',      '~> 1.2.8', :github => 'dkubb/reek'
    gem 'roodi',     '~> 2.1.0'
    gem 'ruby2ruby', '=  1.2.2'
  end
end
