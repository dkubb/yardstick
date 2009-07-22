class Object  #:nodoc:

  # Return the meta class for this instance
  #
  # @return [Class]
  #   the meta class
  #
  # @api private
  def meta_class
    class << self; self end
  end

end # class Object
