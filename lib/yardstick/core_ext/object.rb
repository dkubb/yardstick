class Object
  # Return the meta class for this instance
  #
  # @return [Class]
  #   the meta class
  #
  # @api private
  def meta_class
    class << self; self end
  end
end
