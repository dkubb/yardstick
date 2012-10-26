require 'spec_helper'
require 'yardstick/cli'

shared_examples_for 'displays help' do
  it 'should display the help message' do
    @output.should == <<-OUTPUT.gsub(/^\s{6}/, '')
      Usage: #{OptionParser.new.program_name} [options]
          -v, --version                    print version information and exit
          -h, --help                       display this help and exit
    OUTPUT
  end
end

shared_examples_for 'displays version' do
  it 'should display the program and version' do
    @output.should == "#{OptionParser.new.program_name} #{Yardstick::VERSION}\n"
  end
end

shared_examples_for 'displays coverage summary' do
  it 'should output the coverage summary' do
    @output.should == "\nCoverage: 100.0%  Success: 20  Failed: 0  Total: 20\n"
  end
end

describe Yardstick::CLI do
  def capture_display(&block)
    capture_stdout do
      block.should raise_error(SystemExit)
    end
  end

  describe '.run' do
    describe 'with no arguments' do
      before do
        capture_display { Yardstick::CLI.run }
      end

      it_should_behave_like 'displays help'
    end

    %w[ -h --help ].each do |help_option|
      describe "with #{help_option} option" do
        before do
          capture_display { Yardstick::CLI.run(help_option) }
        end

        it_should_behave_like 'displays help'
      end
    end

    %w[ -v --version ].each do |version_option|
      describe "with #{version_option} option" do
        before do
          capture_display { Yardstick::CLI.run(version_option) }
        end

        it_should_behave_like 'displays version'
      end
    end

    describe 'with a String path' do
      before :all do
        @measurements = capture_stdout { Yardstick::CLI.run(Yardstick::ROOT.join('lib', 'yardstick.rb').to_s) }
      end

      it_should_behave_like 'measured itself'
      it_should_behave_like 'displays coverage summary'
    end

    describe 'with a Pathname' do
      before :all do
        @measurements = capture_stdout { Yardstick::CLI.run(Yardstick::ROOT.join('lib', 'yardstick.rb')) }
      end

      it_should_behave_like 'measured itself'
      it_should_behave_like 'displays coverage summary'
    end

    describe 'with an Array of String objects' do
      before :all do
        @measurements = capture_stdout { Yardstick::CLI.run(*[ Yardstick::ROOT.join('lib', 'yardstick.rb').to_s ]) }
      end

      it_should_behave_like 'measured itself'
      it_should_behave_like 'displays coverage summary'
    end

    describe 'with an Array of Pathname objects' do
      before :all do
        @measurements = capture_stdout { Yardstick::CLI.run(*[ Yardstick::ROOT.join('lib', 'yardstick.rb') ]) }
      end

      it_should_behave_like 'measured itself'
      it_should_behave_like 'displays coverage summary'
    end

    describe 'with invalid option' do
      before do
        capture_display { Yardstick::CLI.run('--invalid') }
      end

      it 'should display the invalid option message' do
        @output.should == "invalid option: --invalid\n"
      end
    end
  end
end
