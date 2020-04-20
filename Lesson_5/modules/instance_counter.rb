module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :instances
    def instances
      @instances
    end
    def instances_add
      @instances ||= 0
      @instances += 1
    end

  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances_add
    end
  end
end
