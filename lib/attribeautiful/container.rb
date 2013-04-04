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
      include EagerBeaver::MethodMissingUtils

      html_element_names << elem_name

      ## handle <elem_name>_element methods
      add_method_matcher do |mm|
        mm.matcher = Proc.new do
          #puts "MATCHING: <elem_name>_element against #{missing_method_name}"
          /\A(\w+)_element\z/ =~ missing_method_name.to_s
          @elem_name = Regexp.last_match ? Regexp.last_match[1] : nil
          #puts "MATCHING: #{Regexp.last_match ? 'SUCESS' : 'FAILURE'}"
          Regexp.last_match
        end

        mm.new_method_code_maker = Proc.new do
          %Q{
            def #{missing_method_name}
              @#{@elem_name}_element ||= Attribeautiful::Element.new
            end
          }
        end
      end

      ## handle <elem_name>_<attr_name>_attr methods
      add_method_matcher do |mm|
        mm.matcher = Proc.new do
          #puts "MATCHING: <elem_name>_<attr_name>_attr against #{missing_method_name}"
          #puts "#{original_caller.class.html_element_names}"
          original_caller.class.html_element_names.detect{ |elem_name|
            #puts "#{elem_name}"
            /\A(#{elem_name})_(\w+)_attr\z/ =~ missing_method_name.to_s
          }
          @elem_name = Regexp.last_match ? Regexp.last_match[1] : nil
          @attr_name = Regexp.last_match ? Regexp.last_match[2] : nil
          #puts "MATCHING: #{Regexp.last_match ? 'SUCESS' : 'FAILURE'}"
          Regexp.last_match
        end

        mm.new_method_code_maker = Proc.new do
          %Q{
            def #{missing_method_name}
              #{@elem_name}_element.#{@attr_name}_attr ||= Attribeautiful::Attribute.new("#{@attr_name}")
            end
          }
        end
      end

      ## handle <elem_name>_<attr_name>_<attr_action> methods
      add_method_matcher do |mm|
        mm.matcher = Proc.new do
          #puts "MATCHING: <elem_name>_<attr_name>_<attr_action> against #{missing_method_name}"
          #puts "#{original_caller.class.html_element_names}"
          original_caller.class.html_element_names.detect{ |elem_name|
            #puts "#{elem_name}"
            Attribeautiful::Attribute.instance_methods.detect do |attr_action|
              #puts "  #{attr_action}"
              /\A(#{elem_name})_(\w+)_(#{attr_action})\z/ =~ missing_method_name.to_s
            end
          }
          @elem_name   = Regexp.last_match ? Regexp.last_match[1] : nil
          @attr_name   = Regexp.last_match ? Regexp.last_match[2] : nil
          @attr_action = Regexp.last_match ? Regexp.last_match[3] : nil
          #puts "MATCHING: #{Regexp.last_match ? 'SUCESS' : 'FAILURE'}"
          Regexp.last_match
        end

        mm.new_method_code_maker = Proc.new do
          %Q{
            def #{@elem_name}_#{@attr_name}_#{@attr_action}(*args, &block)
              #{@elem_name}_#{@attr_name}_attr.#{@attr_action}(*args, &block)
            end
          }
        end
      end

    end
  end

end
