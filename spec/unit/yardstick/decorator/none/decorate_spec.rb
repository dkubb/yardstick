# frozen_string_literal: true

require 'spec_helper'

describe Yardstick::Decorator::NONE, '#decorate' do
  subject { formatter.decorate(string) }

  let(:string)    { 'do not decorate me'   }
  let(:formatter) { described_class }

  it { should eql('do not decorate me') }
end
