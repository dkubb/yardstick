# encoding: utf-8

require 'spec_helper'

describe Yardstick::Document, '#path' do
  subject { described_class.new(docstring).path }

  let(:docstring) { YARD::Registry.all(:method).first.docstring }

  context 'when instance method' do
    before do
      YARD.parse_string(<<-RUBY)
        module Foo
          class Bar
            # Instance method
            #
            # @api public
            def baz(value)
            end
          end
        end
      RUBY
    end

    it { should eql('Foo::Bar#baz') }
  end

  context 'when class method' do
    before do
      YARD.parse_string(<<-RUBY)
        module Foo
          class Bar
            # Instance method
            #
            # @api public
            def self.baz(value)
            end
          end
        end
      RUBY
    end

    it { should eql('Foo::Bar.baz') }
  end
end
