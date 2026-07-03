# frozen_string_literal: true

require 'spec_helper'

module Yardstick
  describe RuleDescription, '.parse' do
    subject { described_class.parse(description) }

    let(:description) { '*subject* should be _option_' }
    let(:tokens) do
      [
        described_class::Token::Subject.new(string: 'subject'),
        described_class::Token::Text.new(string: ' should be '),
        described_class::Token::Option.new(string: 'option')
      ]
    end

    it { should eq(described_class.new(tokens: tokens)) }
  end
end
