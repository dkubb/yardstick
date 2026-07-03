# frozen_string_literal: true

require 'spec_helper'

module Yardstick
  class RuleDescription
    describe Tokenizer, '#tokenize' do
      subject { instance.tokenize }

      let(:instance) { described_class.new(text: input) }

      context 'when plain text' do
        let(:input)  { 'plain string'            }
        let(:tokens) { [Token::Text.new(string: 'plain string')] }

        it { should eq(tokens) }
      end

      context "when input has text wrapped in '*'" do
        let(:input)  { '*special* message' }
        let(:tokens) { [Token::Subject.new(string: 'special'), Token::Text.new(string: ' message')] }

        it { should eq(tokens) }
      end

      context "when input has text wrapped in '_'" do
        let(:input)  { 'underlined _value_' }
        let(:tokens) { [Token::Text.new(string: 'underlined '), Token::Option.new(string: 'value')] }

        it { should eq(tokens) }
      end

      context "when input has both '*' and '_'" do
        let(:input)  { '*subject* and _value_' }
        let(:tokens) do
          [Token::Subject.new(string: 'subject'), Token::Text.new(string: ' and '), Token::Option.new(string: 'value')]
        end

        it { should eq(tokens) }
      end

      context 'when input has multiple delimiters' do
        let(:input)  { '_foo_ and _bar_' }
        let(:tokens) do
          [Token::Option.new(string: 'foo'), Token::Text.new(string: ' and '), Token::Option.new(string: 'bar')]
        end

        it { should eq(tokens) }
      end
    end
  end
end
