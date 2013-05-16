require 'spec_helper'

describe Yardstick, '.measure' do
  describe 'with no arguments' do
    before :all do
      @measurements = Yardstick.measure
    end

    it_should_behave_like 'measured itself'
  end

  describe 'with a config' do
    before :all do
      config = Yardstick::Config.new(:path => Yardstick::ROOT.join('lib', 'yardstick.rb'))
      @measurements = Yardstick.measure(config)
    end

    it_should_behave_like 'measured itself'
  end
end
