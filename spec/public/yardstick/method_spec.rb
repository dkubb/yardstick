# encoding: utf-8

require 'spec_helper'

shared_examples_for 'method is measured' do
  before do
    @measurements = docstring.measure
  end

  it 'should return a MeasurementSet' do
    @measurements.should be_kind_of(Yardstick::MeasurementSet)
  end
end

shared_examples_for 'a valid method' do
  before do
    YARD.parse_string(<<-RUBY)
      # This is a method summary that is the maximum --- exactly 80 characters in length
      #
      # @example
      #   test('Hello World')  # => nil
      #
      # @param [#to_str] value
      #   the value
      #
      # @return [nil]
      #   returns nil
      #
      # @api public
      def test(value)
      end
    RUBY
  end
end

describe Yardstick::Method do
  def docstring
    YARD::Registry.all(:method).first.docstring
  end

  describe '#measure' do
    describe 'with a method summary' do
      it_should_behave_like 'a valid method'
      it_should_behave_like 'method is measured'

      it 'should have a correct measurement' do
        @measurements.detect { |measurement| measurement.description == 'The method summary should be specified' }.should be_ok
      end
    end

    describe 'without a method summary' do
      before do
        YARD.parse_string('def test(value); end')
      end

      it_should_behave_like 'method is measured'

      it 'should have an incorrect measurement' do
        @measurements.detect { |measurement| measurement.description == 'The method summary should be specified' }.should_not be_ok
      end
    end

    describe 'with a method summary that is 80 characters in length' do
      it_should_behave_like 'a valid method'
      it_should_behave_like 'method is measured'

      it 'should have a correct measurement' do
        @measurements.detect { |measurement| measurement.description == 'The method summary should be less than 80 characters in length' }.should be_ok
      end
    end

    describe 'with a method summary that is 81 characters in length' do
      before do
        YARD.parse_string(<<-RUBY)
          # This is a method summary greater than the maximum - it is 81 characters in length
          def test(value)
          end
        RUBY
      end

      it_should_behave_like 'method is measured'

      it 'should have an incorrect measurement' do
        @measurements.detect { |measurement| measurement.description == 'The method summary should be less than 80 characters in length' }.should_not be_ok
      end
    end

    describe 'with a method summary that does not end in a period' do
      it_should_behave_like 'a valid method'
      it_should_behave_like 'method is measured'

      it 'should have a correct measurement' do
        @measurements.detect { |measurement| measurement.description == 'The method summary should not end in a period' }.should be_ok
      end
    end

    describe 'with a method summary that does end in a period' do
      before do
        YARD.parse_string(<<-RUBY)
          # This method summary ends in a period.
          def test(value)
          end
        RUBY
      end

      it_should_behave_like 'method is measured'

      it 'should have an incorrect measurement' do
        @measurements.detect { |measurement| measurement.description == 'The method summary should not end in a period' }.should_not be_ok
      end
    end

    describe 'with a method summary that is on one line' do
      it_should_behave_like 'a valid method'
      it_should_behave_like 'method is measured'

      it 'should have a correct measurement' do
        @measurements.detect { |measurement| measurement.description == 'The method summary should be a single line' }.should be_ok
      end
    end

    describe 'with a method summary that is not on one line' do
      before do
        YARD.parse_string(<<-RUBY)
          # This method summary
          # is on two lines
          def test(value)
          end
        RUBY
      end

      it_should_behave_like 'method is measured'

      it 'should have an incorrect measurement' do
        @measurements.detect { |measurement| measurement.description == 'The method summary should be a single line' }.should_not be_ok
      end
    end

    describe 'with a method that has an @example tag' do
      it_should_behave_like 'a valid method'
      it_should_behave_like 'method is measured'

      it 'should have a correct measurement' do
        @measurements.detect { |measurement| measurement.description == 'The public/semipublic method should have an example specified' }.should be_ok
      end
    end

    describe 'with a method that is private' do
      before do
        YARD.parse_string(<<-RUBY)
          # @api private
          def test(value)
          end
        RUBY
      end

      it_should_behave_like 'method is measured'

      it 'should be skipped' do
        @measurements.detect { |measurement| measurement.description == 'The public/semipublic method should have an example specified' }.should be_skip
      end
    end

    describe 'with a method that does not have an @example tag, and has an undefined @return tag' do
        before do
          YARD.parse_string(<<-RUBY)
            # @return [undefined]
            #
            # @api public
            def test(value)
            end
          RUBY
        end

        it_should_behave_like 'method is measured'

        it 'should be skipped' do
          @measurements.detect { |measurement| measurement.description == 'The public/semipublic method should have an example specified' }.should be_skip
        end
      end

    describe 'with a method that has an @api tag' do
      it_should_behave_like 'a valid method'
      it_should_behave_like 'method is measured'

      it 'should have a correct measurement' do
        @measurements.detect { |measurement| measurement.description == 'The @api tag should be specified' }.should be_ok
      end
    end

    describe 'with a method that does not have an @api tag' do
      before do
        YARD.parse_string('def test(value); end')
      end

      it_should_behave_like 'method is measured'

      it 'should have an incorrect measurement' do
        @measurements.detect { |measurement| measurement.description == 'The @api tag should be specified' }.should_not be_ok
      end
    end

    describe 'with a method that has a public @api tag' do
      it_should_behave_like 'a valid method'
      it_should_behave_like 'method is measured'

      it 'should have a correct measurement' do
        @measurements.detect { |measurement| measurement.description == 'The @api tag must be either public, semipublic or private' }.should be_ok
      end
    end

    describe 'with a method that has an invalid @api tag' do
      before do
        YARD.parse_string(<<-RUBY)
          # @api invalid
          def test(value)
          end
        RUBY
      end

      it_should_behave_like 'method is measured'

      it 'should have an incorrect measurement' do
        @measurements.detect { |measurement| measurement.description == 'The @api tag must be either public, semipublic or private' }.should_not be_ok
      end
    end

    describe 'with a protected method and a semipublic @api tag' do
      before do
        YARD.parse_string(<<-RUBY)
          protected

          # @api semipublic
          def test(value)
          end
        RUBY
      end

      it_should_behave_like 'method is measured'

      it 'should have a correct measurement' do
        @measurements.detect { |measurement| measurement.description == 'A method with protected visibility must have an @api tag of semipublic or private' }.should be_ok
      end
    end

    describe 'with a protected method and a private @api tag' do
      before do
        YARD.parse_string(<<-RUBY)
          protected

          # @api private
          def test(value)
          end
        RUBY
      end

      it_should_behave_like 'method is measured'

      it 'should have a correct measurement' do
        @measurements.detect { |measurement| measurement.description == 'A method with protected visibility must have an @api tag of semipublic or private' }.should be_ok
      end
    end

    describe 'with a protected method and a public @api tag' do
      before do
        YARD.parse_string(<<-RUBY)
          protected

          # @api public
          def test(value)
          end
        RUBY
      end

      it_should_behave_like 'method is measured'

      it 'should have an incorrect measurement' do
        @measurements.detect { |measurement| measurement.description == 'A method with protected visibility must have an @api tag of semipublic or private' }.should_not be_ok
      end
    end

    describe 'with a private method and a private @api tag' do
      before do
        YARD.parse_string(<<-RUBY)
          private

          # @api private
          def test(value)
          end
        RUBY
      end

      it_should_behave_like 'method is measured'

      it 'should have a correct measurement' do
        @measurements.detect { |measurement| measurement.description == 'A method with private visibility must have an @api tag of private' }.should be_ok
      end
    end

    describe 'with a private method and a public @api tag' do
      before do
        YARD.parse_string(<<-RUBY)
          private

          # @api public
          def test(value)
          end
        RUBY
      end

      it_should_behave_like 'method is measured'

      it 'should have an incorrect measurement' do
        @measurements.detect { |measurement| measurement.description == 'A method with private visibility must have an @api tag of private' }.should_not be_ok
      end
    end

    describe 'with a private method and a semipublic @api tag' do
      before do
        YARD.parse_string(<<-RUBY)
          private

          # @api semipublic
          def test(value)
          end
        RUBY
      end

      it_should_behave_like 'method is measured'

      it 'should have an incorrect measurement' do
        @measurements.detect { |measurement| measurement.description == 'A method with private visibility must have an @api tag of private' }.should_not be_ok
      end
    end

    describe 'with a method that has a @return tag' do
      it_should_behave_like 'a valid method'
      it_should_behave_like 'method is measured'

      it 'should have a correct measurement' do
        @measurements.detect { |measurement| measurement.description == 'The @return tag should be specified' }.should be_ok
      end
    end

    describe 'with a method that does not have a @return tag' do
      before do
        YARD.parse_string('def test(value); end')
      end

      it_should_behave_like 'method is measured'

      it 'should have an incorrect measurement' do
        @measurements.detect { |measurement| measurement.description == 'The @return tag should be specified' }.should_not be_ok
      end
    end
  end
end
