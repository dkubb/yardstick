# frozen_string_literal: true

class DescriptionToken < Data.define(:string)
  def decorate
    string
  end
end

class ValidRule
  class << self
    attr_accessor :description
  end

  attr_reader :document

  def initialize(document, *)
    @document = document
  end

  self.description = [DescriptionToken.new(string: 'successful')]

  def enabled?
    true
  end

  def valid?
    true
  end

  def validatable?
    true
  end
end

class NotValidatableRule < ValidRule
  self.description = [DescriptionToken.new(string: 'skipped')]

  def validatable?
    false
  end
end

class InvalidRule < ValidRule
  self.description = [DescriptionToken.new(string: 'not successful')]

  def valid?
    false
  end
end

class DisabledRule < ValidRule
  self.description = [DescriptionToken.new(string: 'not enabled')]

  def enabled?
    false
  end
end
