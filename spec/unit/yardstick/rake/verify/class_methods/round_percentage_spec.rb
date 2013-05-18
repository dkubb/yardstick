require 'spec_helper'
require 'yardstick/rake/verify'

describe Yardstick::Rake::Verify, '.round_percentage' do
  subject { described_class.round_percentage(12.3456) }

  it { should eq(12.4) }
end
