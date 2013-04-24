require 'spec_helper'

describe Yardstick::Document, '#line' do
  subject { described_class.new(docstring).line }

  let(:docstring) { YARD::Registry.all(:method).first.docstring }

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

  it { should be(6) }
end
