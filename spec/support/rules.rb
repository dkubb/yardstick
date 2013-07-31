class ValidRule
  class << self
    attr_accessor :description
  end

  attr_reader :document

  def initialize(document, *)
    @document = document
  end

  self.description = 'successful'

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
  self.description = 'skipped'

  def validatable?
    false
  end
end

class InvalidRule < ValidRule
  self.description = 'not successful'

  def valid?
    false
  end
end

class DisabledRule < ValidRule
  self.description = 'not enabled'

  def enabled?
    false
  end
end
