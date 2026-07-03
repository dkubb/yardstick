# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yardstick::RuleDescription::Formatter::Null, '#format' do
  subject { described_class.new(description: description).format }

  let(:description) do
    Yardstick::RuleDescription.new(tokens: [
                                     Yardstick::RuleDescription::Token::Subject.new(string: 'important'),
                                     Yardstick::RuleDescription::Token::Text.new(string: ' recommended '),
                                     Yardstick::RuleDescription::Token::Option.new(string: 'value'),
                                   ])
  end

  it { should eql('important recommended value') }
  it { should be_a(String) }
end
