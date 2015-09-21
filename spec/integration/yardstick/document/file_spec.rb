# encoding: utf-8

require 'spec_helper'

describe Yardstick::Document, '#file' do
  subject { described_class.new(docstring).file }

  let(:docstring) { YARD::Registry.all(:method).first.docstring }
  let(:file)      { Yardstick::ROOT.join('lib', 'yardstick.rb') }

  before { YARD.parse([file.to_s], [], YARD::Logger::ERROR) }

  it { should be_kind_of(Pathname) }

  it { should eql(file) }
end
