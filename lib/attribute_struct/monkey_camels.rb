require 'attribute_struct'

module MonkeyCamels

  class << self
    def included(klass)
      klass.class_eval do

        include Humps

        alias_method :un_camel_to_s, :to_s
        alias_method :to_s, :camel_to_s
        alias_method :un_camel_initialize_copy, :initialize_copy
        alias_method :initialize_copy, :camel_initialize_copy
      end
    end
  end

  # Create a camel copy based on settings
  #
  # @return [String]
  def camel_initialize_copy(orig)
    new_val = un_camel_initialize_copy(orig)
    orig._camel? ? new_val : new_val._no_hump
  end

  # Provide string formatted based on hump setting
  #
  # @return [String]
  def camel_to_s
    val = un_camel_to_s
    _camel? ? val : val._no_hump
  end

  module Humps

    # @return [TrueClass, FalseClass] camelized
    def _camel?
      !@__not_camel
    end

    # @return [self] disable camelizing
    def _no_hump
      @__not_camel = true
      self
    end

    # @return [self] enable camelizing
    def _hump
      @__not_camel = false
      self
    end

  end

end

# Force some monkeys around
String.send(:include, MonkeyCamels)
Symbol.send(:include, MonkeyCamels)

# Specialized String type
class CamelString < String
  def initialize(val=nil)
    super
    if(val.respond_to?(:_camel?))
      _no_hump unless val._camel?
    end
  end
end
