module ClassAccessor
  def cattr_accessor(arg_name, options = { instance_accessor: true })
    class_var_name = "@@#{ arg_name.to_s }"
    if(options[:instance_reader])
      class_eval do
        define_reader(arg_name, class_var_name)
      end
    end
    if (options[:instance_writer])
      class_eval do
        define_writer(arg_name, class_var_name)
      end
    end
    if ((options[:instance_reader] || options[:instance_writer])&&options[:instance_accessor])
      showError()
    end
    if(options[:instance_accessor])
      class_eval do
        define_reader(arg_name, class_var_name)
        define_writer(arg_name, class_var_name)
      end
    end
  end

  private
  
  def define_writer(arg_name, class_var_name)
    define_singleton_method("#{ arg_name.to_s }=") do |value|
      class_variable_set(class_var_name.to_sym, value)
    end
  end

  def define_reader(arg_name, class_var_name)
    define_singleton_method("#{ arg_name.to_s }") do
      class_variable_get(class_var_name) 
    end
  end

  def showError()
    puts "Cannot make both accessor and writer or reader"
  end

end