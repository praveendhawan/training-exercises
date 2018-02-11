module DirtyObject
  def self.included(klass)
    klass.extend A
  end

  module A
    def define_dirty_attributes(*args)
      ivar_name = "@dirty_attributes"
      instance_variable_set("@dirty_attributes", args)
      args.each do |arg|
        arg_symbol = arg.to_sym
        define_method("#{ arg }_was") do
          instance_variable_get(ivar_name)[arg_symbol][0]
        end

        writer_method = instance_method("#{ arg }=")

        define_method("#{ arg }=") do |value|
          prev_value = instance_variable_get("@#{ arg }")
          if((@dirty_attributes[arg_symbol] != nil) && (@dirty_attributes[arg_symbol][0] == value))
            @dirty_attributes.delete(arg_symbol)
          else
            @dirty_attributes[arg_symbol] = [prev_value, value]
          end
          writer_method.bind(self).call(value)
        end
      end

      define_method("changed?") do
        !changes.empty?
      end

      define_method("changes") do
        @dirty_attributes.select do |key, value|
          !(value[0] == value[1])
        end
      end

      define_method("save") do
        @dirty_attributes = {}
        true
      end
    end
  end
  def initialize()
      @dirty_attributes = {}
  end
  
end