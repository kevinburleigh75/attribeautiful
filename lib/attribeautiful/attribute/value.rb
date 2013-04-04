module Attribeautiful
  class Attribute

    class Value

      attr_accessor :strings

      def initialize
        self.strings     = []
        self.use_spaces
        self
      end

      def use_spaces
        @use_spaces = true
        self
      end

      def use_semicolons
        @use_spaces = false
        self
      end

      def use_spaces?
        @use_spaces
      end

      def add(*args)
        self.strings << args
        self.strings = strings.flatten.uniq
      end

      def to_s
        use_spaces? ? strings.join(" ") : strings.join(";")
      end

    end

  end
end