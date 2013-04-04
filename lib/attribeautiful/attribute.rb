require  File.join(File.dirname(__FILE__), "attribute_name")
require  File.join(File.dirname(__FILE__), "attribute_string")

module Attribeautiful

  class Attribute

    attr_accessor :attr_name
    attr_accessor :attr_string

    def initialize(name)
      self.attr_name   = Attribeautiful::AttributeName.new(name)
      self.attr_string = Attribeautiful::AttributeString.new
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
      self.attr_string.add(*args)
      self
    end

    def use_spaces
      self.attr_string.use_spaces
      self
    end

    def use_semicolons
      self.attr_string.use_semicolons
      self
    end

    def to_s
      return "" if attr_string.to_s.empty?
      return "#{attr_name}=\"#{attr_string}\""
    end

  end

end