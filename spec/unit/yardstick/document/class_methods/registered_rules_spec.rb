require 'spec_helper'

describe Yardstick::Document, '.registered_rules' do
  subject { described_class.registered_rules }

  it { should_not be_empty }
end
