# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yardstick::RuleDescription::Formatter, '#format' do
  subject { described_class.new(description: description).format }

  let(:description) do
    [
      Yardstick::RuleDescription::Token::Subject.new(string: 'important'),
      Yardstick::RuleDescription::Token::Text.new(string: ' recommended '),
      Yardstick::RuleDescription::Token::Option.new(string: 'value')
    ]
  end

  it do
    should eql("\e[1;31mimportant\e[0m recommended \e[4;33mvalue\e[0m")
  end

  it { should be_a(String) }
end
