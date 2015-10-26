# encoding: utf-8

require 'spec_helper'

RSpec.describe Yardstick::RuleDescription::Formatter, '#format' do
  subject { described_class.new(description).format }

  let(:description) do
    [
      Yardstick::RuleDescription::Token::Subject.new('important'),
      Yardstick::RuleDescription::Token::Text.new(' recommended '),
      Yardstick::RuleDescription::Token::Option.new('value')
    ]
  end

  it do
    should eql("\e[1;31mimportant\e[0m recommended \e[4;33mvalue\e[0m")
  end

  it { should be_a(String) }
end
