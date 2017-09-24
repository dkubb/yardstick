# encoding: utf-8

require 'spec_helper'
require 'yardstick/cli'

shared_examples_for 'displays help' do
  let(:message) do
    <<-OUTPUT.gsub(/^\s{6}/, '')
      Usage: #{OptionParser.new.program_name} [options]
          -c, --config FILE                load config file (default .yardstick.yml)
          -v, --version                    print version information and exit
          -h, --help                       display this help and exit
    OUTPUT
  end

  it 'displays the help message' do
    expect(@output).to eql(message)
  end
end

shared_examples_for 'displays version' do
  it 'displays the program and version' do
    expect(@output)
      .to eql("#{OptionParser.new.program_name} #{Yardstick::VERSION}\n")
  end
end

shared_examples_for 'displays coverage summary' do
  it 'outputs the coverage summary' do
    summary = /YARD-Coverage: [\d.]+%  Success: (\d+)  Failed: \d+  Total: \d+\n/
    expect(@output).to match(summary)
  end
end

shared_examples_for 'measures files' do |files|
  it 'includes files in documentation coverage' do
    files_measured = @measurements.map {|m| m.document.file }.uniq
    expect(files_measured).to include(*files.map {|f| Pathname(f) })
  end
end

shared_examples_for 'only measures files' do |files|
  it 'only includes files in documentation coverage' do
    files_measured = @measurements.map {|m| m.document.file }.uniq
    expect(files_measured).to match_array(files.map {|f| Pathname(f) })
  end
end

describe Yardstick::CLI do
  def capture_display(&block)
    capture_stdout do
      expect(block).to raise_error(SystemExit)
    end
  end

  describe '.run' do
    describe 'with no arguments' do
      before do
        @measurements = capture_stdout { described_class.run }
      end

      # By default, all files in lib/ are measured
      it_should_behave_like 'measures files', Dir["lib/yardstick/{cli,config,rules/summary}.rb"]
    end

    config = "spec/fixtures/config1.yml" # contains { path: 'lib/yardstick/document.rb' }
    [['-c', config], ['--config', config]].each do |config_options|
      describe  "with #{config_options} options" do
        before do
          @measurements = capture_stdout { described_class.run(*config_options) }
        end

        it_should_behave_like 'measured itself'
        it_should_behave_like 'displays coverage summary'
        it_should_behave_like 'only measures files', %w[lib/yardstick/document.rb]
      end
    end

    describe "with --config does-not-exist.yml options" do
      before do
        capture_display { described_class.run("--config", "does-not-exist.yml") }
      end

      it "exits with an error message about config file not existing" do
        expect(@output).to eql "Config file not found: does-not-exist.yml\n"
      end
    end

    %w[-h --help].each do |help_option|
      describe "with #{help_option} option" do
        before do
          capture_display { described_class.run(help_option) }
        end

        it_should_behave_like 'displays help'
      end
    end

    %w[-v --version].each do |version_option|
      describe "with #{version_option} option" do
        before do
          capture_display { described_class.run(version_option) }
        end

        it_should_behave_like 'displays version'
      end
    end

    describe 'with a .yardstick.yml config' do
      before do
        config_file = File.open('.yardstick.yml', 'w') do |file|
          file.write("---\npath: ['lib/yardstick/cli.rb']")
          file.path # Passed back through block for assignment
        end

        begin
          @measurements = capture_stdout { described_class.run }
        ensure
          File.unlink(config_file)
        end
      end

      it_should_behave_like 'measured itself'
      it_should_behave_like 'displays coverage summary'
      it_should_behave_like 'only measures files', %w[lib/yardstick/cli.rb]
    end

    describe 'with a String path' do
      before :all do
        @measurements = capture_stdout { described_class.run(Yardstick::ROOT.join('lib', 'yardstick.rb').to_s) }
      end

      it_should_behave_like 'measured itself'
      it_should_behave_like 'displays coverage summary'
    end

    describe 'with a Pathname' do
      before :all do
        @measurements = capture_stdout { described_class.run(Yardstick::ROOT.join('lib', 'yardstick.rb')) }
      end

      it_should_behave_like 'measured itself'
      it_should_behave_like 'displays coverage summary'
    end

    describe 'with an Array of String objects' do
      before :all do
        @measurements = capture_stdout { described_class.run(*[Yardstick::ROOT.join('lib', 'yardstick.rb').to_s]) }
      end

      it_should_behave_like 'measured itself'
      it_should_behave_like 'displays coverage summary'
    end

    describe 'with an Array of Pathname objects' do
      before :all do
        @measurements = capture_stdout { described_class.run(*[Yardstick::ROOT.join('lib', 'yardstick.rb')]) }
      end

      it_should_behave_like 'measured itself'
      it_should_behave_like 'displays coverage summary'
    end

    describe 'with invalid option' do
      before do
        capture_display { described_class.run('--invalid') }
      end

      it 'displays the invalid option message' do
        expect(@output).to eql("invalid option: --invalid\n")
      end
    end
  end
end
