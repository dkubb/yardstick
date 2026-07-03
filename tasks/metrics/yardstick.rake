# frozen_string_literal: true

require 'yaml'
require 'yardstick/rake/measurement'
require 'yardstick/rake/verify'

yardstick_options = YAML.safe_load_file('config/yardstick.yml')

namespace :metrics do
  namespace :yardstick do
    Yardstick::Rake::Measurement.new(:measure, yardstick_options)
    Yardstick::Rake::Verify.new(:verify, yardstick_options)
  end
end

CLEAN << 'measurements'
