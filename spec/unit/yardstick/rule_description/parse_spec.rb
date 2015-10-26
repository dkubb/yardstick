# encoding: utf-8

require 'spec_helper'

module Yardstick
  describe RuleDescription, '.parse' do
    subject { described_class.parse(description) }

    let(:description) { '*subject* should be _option_' }
    let(:tokens) do
      [
        described_class::Token::Subject.new('subject'),
        described_class::Token::Text.new(' should be '),
        described_class::Token::Option.new('option')
      ]
    end

    it { should eq(described_class.new(tokens)) }
  end
end
