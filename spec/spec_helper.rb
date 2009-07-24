require 'pathname'
require 'rubygems'
require 'spec/autorun'

require Pathname(__FILE__).dirname.expand_path.join('..', 'lib', 'yardstick')

Pathname.glob(Yardstick::ROOT.join('lib', '**', '*.rb').to_s).sort.each do |file|
  require file.to_s.chomp('.rb')
end

Spec::Runner.configure do |config|
  config.before :all do
    YARD::Registry.clear
  end

  config.before do
    YARD::Registry.clear
  end

  def capture_stdout
    $stdout = StringIO.new
    yield
  ensure
    $stdout.rewind
    @output = $stdout.read
    $stdout = STDOUT
  end

  def capture_stderr
    $stderr = StringIO.new
    yield
  ensure
    $stderr.rewind
    @output = $stderr.read
    $stderr = STDERR
  end
end

shared_examples_for 'measured itself' do
  it 'should return a MeasurementSet' do
    @measurements.should be_kind_of(Yardstick::MeasurementSet)
  end

  it 'should be non-empty' do
    @measurements.should_not be_empty
  end

  it 'should all be correct' do
    @measurements.each { |measurement| measurement.should be_ok }
  end
end
