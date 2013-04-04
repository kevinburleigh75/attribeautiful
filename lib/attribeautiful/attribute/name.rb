module Attribeautiful
  class Attribute

    class Name
      attr_accessor :text

      def initialize(name)
        self.text = name
        self.use_dashes
      end

      def use_dashes?
        @use_dashes
      end

      def use_dashes
        @use_dashes = true
        self
      end

      def use_underscores
        @use_dashes = false
        self
      end

      def to_s
        use_dashes? ? text.gsub('_', '-') : text.gsub('-', '_')
      end
    end

  end
end
