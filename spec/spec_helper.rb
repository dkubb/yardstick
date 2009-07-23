require 'rubygems'
require 'spec'
require 'pathname'

require Pathname(__FILE__).dirname.expand_path.join('..', 'lib', 'yardstick')

Pathname.glob(Yardstick::ROOT.join('lib', '**', '*.rb')).sort.each do |file|
  require file.to_s.chomp('.rb')
end

Spec::Runner.configure do |config|
  config.before do
    YARD::Registry.clear
  end
end

shared_examples_for 'measured itself' do
  it 'should return an Array' do
    @measurements.should be_kind_of(Array)
  end

  it 'should be non-empty' do
    @measurements.should_not be_empty
  end

  it 'should all be measurements' do
    @measurements.each { |measurement| measurement.should be_kind_of(Yardstick::Measurement) }
  end

  it 'should all be correct' do
    @measurements.each { |measurement| measurement.should be_ok }
  end
end
