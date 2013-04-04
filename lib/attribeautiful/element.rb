require 'eager_beaver'
require File.join(File.dirname(__FILE__), "attribute")

module Attribeautiful

  class Element
    include EagerBeaver::MethodMissingUtils

    ## handle <attr_name>_attr methods
    add_method_matcher do |mm|
      mm.matcher = Proc.new do
        /\A(\w+)_attr/ =~ missing_method_name
        @attr_name = Regexp.last_match ? Regexp.last_match[1] : nil
      end

      mm.new_method_code_maker = Proc.new do
        %Q{
          def #{missing_method_name}
            @#{@attr_name}_attr ||= Attribeautiful::Attribute.new("#{@attr_name}")
          end
        }
      end
    end
  end

end
