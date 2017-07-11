module Accessors

  @attr_history = []

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods  

    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |value| 
          @attr_history << instance_variable_get(var_name)
          instance_variable_set(var_name, value) 
        end

        define_method("#{name}_history") { @attr_history.inspect }
      end
    end

    def strong_attr_accessor(name, var_class)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value| 
        raise "Type error" if value.instance_of?(var_class)
        instance_variable_set(var_name, value)
      end
    end   

  end
end