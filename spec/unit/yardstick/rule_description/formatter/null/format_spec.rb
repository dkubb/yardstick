# encoding: utf-8

require 'spec_helper'

RSpec.describe Yardstick::RuleDescription::Formatter::Null, '#format' do
  subject { described_class.new(description).format }

  let(:description) do
    Yardstick::RuleDescription.new([
      Yardstick::RuleDescription::Token::Subject.new('important'),
      Yardstick::RuleDescription::Token::Text.new(' recommended '),
      Yardstick::RuleDescription::Token::Option.new('value'),
    ])
  end

  it { should eql('important recommended value') }
  it { should be_a(String) }
end
