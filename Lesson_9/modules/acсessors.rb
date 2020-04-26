# frozen_string_literal: true

module Acсessors
  def self.included(base)
    base.extend self
  end

  def attr_accessor_with_history(*names)
    names.each do |name|
      set_var_name = "#{name}=".to_sym
      var_name = "@#{name}".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method(set_var_name) do |value|
        @all_values ||= {}
        @all_values[name] ||= []
        @all_values[name] << value

        instance_variable_set var_name, value
      end

      define_method("#{name}_history") do
        return [] if @all_values.nil? || @all_values[name].nil?

        @all_values[name]
      end
    end
  end

  def strong_attr_accessor(name, cls_name)
    set_var_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(set_var_name) }

    define_method("#{name}=".to_sym) do |value|
      raise 'Неправильный тип' unless value.class == cls_name

      instance_variable_set(set_var_name, value)
    end
  end
end
