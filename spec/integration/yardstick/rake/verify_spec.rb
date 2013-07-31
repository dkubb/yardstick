require 'spec_helper'
require 'yardstick/rake/verify'

describe Yardstick::Rake::Verify do
  before do
    Yardstick::Rake::Verify.new do |verify|
      verify.threshold = 100
      verify.path = 'lib/yardstick.rb'
    end
  end

  it 'should display coverage summary when executed' do
    capture_stdout { Rake::Task['verify_measurements'].execute }

    expect(@output).to eql("YARD-Coverage: 100.0% (threshold: 100%)\n")
  end
end
