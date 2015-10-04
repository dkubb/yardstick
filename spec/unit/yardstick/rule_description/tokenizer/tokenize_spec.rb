# encoding: utf-8

require 'spec_helper'

module Yardstick
  class RuleDescription
    describe Tokenizer, '#tokenize' do
      subject { instance.tokenize }

      let(:instance) { described_class.new(input) }

      context 'when plain text' do
        let(:input)  { 'plain string'            }
        let(:tokens) { [Token::Text.new('plain string')] }

        it { should eq(tokens) }
      end

      context "when input has text wrapped in '*'" do
        let(:input)  { '*special* message' }
        let(:tokens) { [Token::Subject.new('special'), Token::Text.new(' message')] }

        it { should eq(tokens) }
      end

      context "when input has text wrapped in '_'" do
        let(:input)  { 'underlined _value_' }
        let(:tokens) { [Token::Text.new('underlined '), Token::Option.new('value')] }

        it { should eq(tokens) }
      end

      context "when input has both '*' and '_'" do
        let(:input)  { '*subject* and _value_' }
        let(:tokens) do
          [Token::Subject.new('subject'), Token::Text.new(' and '), Token::Option.new('value')]
        end

        it { should eq(tokens) }
      end

      context 'when input has multiple delimiters' do
        let(:input)  { '_foo_ and _bar_' }
        let(:tokens) do
          [Token::Option.new('foo'), Token::Text.new(' and '), Token::Option.new('bar')]
        end

        it { should eq(tokens) }
      end
    end
  end
end
