require 'spec_helper'

describe Yardstick::Rule, '.inherited' do
  let(:subclass) { Class.new(Yardstick::Rule) }

  after do
    Yardstick::Document.registered_rules.delete(subclass)
  end

  it 'registers rule' do
    Yardstick::Document.registered_rules.should include(subclass)
  end
end
