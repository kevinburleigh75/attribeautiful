require 'eager_beaver'
require File.join(File.dirname(__FILE__), "attribute")

module Attribeautiful

  class Element
    include EagerBeaver

    ## handle <attr_name>_attr methods
    add_method_handler do |mh|
      mh.match = lambda {
        /\A(\w+)_attr/ =~ context.missing_method_name
        context.attr_name = $1
        return Regexp.last_match
      }

      mh.handle = lambda {
        %Q{
          def #{context.missing_method_name}
            @#{context.attr_name}_attr ||= Attribeautiful::Attribute.new("#{context.attr_name}")
          end
        }
      }
    end
  end

end
