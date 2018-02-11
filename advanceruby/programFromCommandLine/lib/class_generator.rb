class ClassGenerator

  def self.create(class_name)
    Object.const_set(class_name, Class.new)
  end

  def self.add_instance_method(class_name, method_name, method_code)
    class_name.class_eval do
      define_method(method_name) do
        eval(method_code)
      end
    end    
  end
end