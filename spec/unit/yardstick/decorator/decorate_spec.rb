# encoding: utf-8

require 'spec_helper'

describe Yardstick::Decorator, '#decorate' do
  subject { formatter.decorate(string) }

  let(:string)    { 'decorate me'                    }
  let(:color)     { :red                             }
  let(:mode)      { :bold                            }
  let(:formatter) { described_class.new(color, mode) }

  it { should eql("\e[1;31mdecorate me\e[0m") }

  context 'when color is yellow' do
    let(:color) { :yellow }

    it { should eql("\e[1;33mdecorate me\e[0m") }
  end

  context 'when mode is underline' do
    let(:mode) { :underline }

    it { should eql("\e[4;31mdecorate me\e[0m") }
  end
end
