require File.join(File.dirname(__FILE__), "attribute/name")
require File.join(File.dirname(__FILE__), "attribute/value")
require 'active_support/lazy_load_hooks'
require 'active_support/core_ext/string'

module Attribeautiful

  class Attribute

    attr_accessor :attr_name
    attr_accessor :attr_value

    def initialize(name)
      self.attr_name  = Attribeautiful::Attribute::Name.new(name)
      self.attr_value = Attribeautiful::Attribute::Value.new
      self
    end

    def use_underscores
      self.attr_name.use_underscores
      self
    end

    def use_dashes
      self.attr_name.use_dashes
      self
    end

    def add(*args)
      self.attr_value.add(*args)
      self
    end

    def use_spaces
      self.attr_value.use_spaces
      self
    end

    def use_semicolons
      self.attr_value.use_semicolons
      self
    end

    def to_s
      return "" if attr_value.to_s.empty?
      return "#{attr_name}=\"#{attr_value}\"".html_safe
    end

  end

end