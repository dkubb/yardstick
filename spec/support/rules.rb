class ValidRule < Yardstick::Rule
  self.description = 'successful'
  def valid?; true; end
end

class NotValidatableRule < ValidRule
  self.description = 'skipped'
  def validatable?; false; end
end

class InvalidRule < ValidRule
  self.description = 'not successful'
  def valid?; false; end
end

class DisabledRule < ValidRule
  self.description = 'not enabled'
  def enabled?; false; end
end
