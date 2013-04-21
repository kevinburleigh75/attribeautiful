require 'eager_beaver'

require File.join(File.dirname(__FILE__), 'element')
require File.join(File.dirname(__FILE__), 'attribute')

module Attribeautiful

  def self.included(includer)
    includer.extend(ClassMethods)
  end

  module ClassMethods

    def html_element_names
      @html_element_names ||= []
    end

    def html_element(elem_name)
      include EagerBeaver

      html_element_names << elem_name

      ## handle <elem_name>_element methods
      add_method_handler do |mh|
        mh.match = lambda {
          #puts "MATCHING: <elem_name>_element against #{missing_method_name}"
          context.elem_name = $1 if /\A(\w+)_element\z/ =~ context.missing_method_name
          #puts "MATCHING: #{Regexp.last_match ? 'SUCESS' : 'FAILURE'}"
          return Regexp.last_match
        }

        mh.handle = lambda {
          %Q{
            def #{context.missing_method_name}
              @#{context.elem_name}_element ||= Attribeautiful::Element.new
            end
          }
        }
      end

      ## handle <elem_name>_<attr_name>_attr methods
      add_method_handler do |mh|
        mh.match = lambda {
          #puts "MATCHING: <elem_name>_<attr_name>_attr against #{missing_method_name}"
          #puts "#{original_receiver.class.html_element_names}"
          context.original_receiver.class.html_element_names.detect{ |elem_name|
            #puts "#{elem_name}"
            /\A(#{elem_name})_(\w+)_attr\z/ =~ context.missing_method_name
          }
          context.elem_name = $1
          context.attr_name = $2
          #puts "MATCHING: #{Regexp.last_match ? 'SUCESS' : 'FAILURE'}"
          return Regexp.last_match
        }

        mh.handle = lambda {
          %Q{
            def #{context.missing_method_name}
              #{context.elem_name}_element.#{context.attr_name}_attr ||= Attribeautiful::Attribute.new("#{context.attr_name}")
            end
          }
        }
      end

      ## handle <elem_name>_<attr_name>_<attr_action> methods
      add_method_handler do |mh|
        mh.match = lambda {
          #puts "MATCHING: <elem_name>_<attr_name>_<attr_action> against #{missing_method_name}"
          #puts "#{original_receiver.class.html_element_names}"
          context.original_receiver.class.html_element_names.detect do |elem_name|
            #puts "#{elem_name}"
            Attribeautiful::Attribute.instance_methods.detect do |attr_action|
              #puts "  #{attr_action}"
              /\A(#{elem_name})_(\w+)_(#{attr_action})\z/ =~ context.missing_method_name
            end
          end

          context.elem_name   = $1
          context.attr_name   = $2
          context.attr_action = $3
          #puts "MATCHING: #{Regexp.last_match ? 'SUCESS' : 'FAILURE'}"
          return Regexp.last_match
        }

        mh.handle = lambda {
          %Q{
            def #{context.missing_method_name}(*args, &block)
              #{context.elem_name}_#{context.attr_name}_attr.#{context.attr_action}(*args, &block)
            end
          }
        }
      end

    end
  end

end
