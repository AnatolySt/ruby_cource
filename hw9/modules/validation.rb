module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_writer :types

    def validate(name, type, args*)
      @types ||= []
      @types << {name: name, type: type, args: args}
    end
  end

  module InstanceMethods
    def validate!
      self.class.types.each do |variable|
        value = instance_variable_get("@#{variable[:name]}")
        send variable[:type], value, variable[:args]
      end
    end

    def presence(value)
      raise "Presense error" if value.nil? || value.to_s.empty?
    end

    def format(value, format)
      raise "Format error" if value !~ Regexp.new(format)
    end

    def type(value, type)
      raise "Type error" if value.instance_of?(type[0])
    end

    def valid?
      validate!
    rescue
      false
    end
  end
end
