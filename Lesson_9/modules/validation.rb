# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations
    def validate(name, type, *options)
      @validations ||= {}
      @validations[name] == { type: type, options: options }
    end
  end

  module InstanceMethods

    def validate!

      self.class.validations.each do |name, value|
        presence = instance_variable_get("@#{name}")
        send("validate_#{value[:type]}", presence, value[:options])

      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    private

    def validate_presence(value)
      raise 'Нет аргументов' if value.nil? || value.empty?
    end

    def validate_format(name, format)
      value = instance_variable_get("@#{name}")
      raise 'Неверный формат' unless value =~ format.first
    end

    def validate_type(name, type)
      type_class = instance_variable_get("@#{name}").to_s
      raise 'Неверный тип' unless type_class.class == type
    end
  end
end
