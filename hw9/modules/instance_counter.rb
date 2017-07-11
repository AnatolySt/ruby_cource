module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instance_num
    end

    def instance_count
      @instance_num ||= 0
      @instance_num += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instance_count
    end
  end
end

class Native
  include InstanceCounter

  def initialize
    register_instance
  end
end
