require 'spec_helper'

describe Yardstick::Document, '#has_tag?' do
  subject { described_class.new(docstring).has_tag?(name) }

  let(:docstring) { mock('docstring') }
  let(:name)      { 'tag name' }

  it 'delegates to docstring' do
    docstring.should_receive(:has_tag?).with(name)
    subject
  end
end
