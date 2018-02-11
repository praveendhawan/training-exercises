module Relationships
  def has_many(associated_model, klass)
    ivar_name = "@#{ associated_model }"

    define_method(associated_model) do
      instance_variable_get(ivar_name)
    end

    define_method("#{ associated_model }=") do |val|
      instance_variable_set(ivar_name, val)
    end

    define_method("create_#{ associated_model }") do |description|
      if(public_send(associated_model.to_sym).nil?)
        eval("#{ ivar_name } = #{ [] }")
      end
      user_id = id
      associated_model_array = public_send(associated_model.to_sym)
      associated_model_array << klass.instance_eval { new(description, user_id) }
      public_send("#{ associated_model }=".to_sym, associated_model_array)
    end
    
    define_method("all_#{ associated_model }") do
      instance_variable_get(ivar_name).each { |model| model.to_s }
    end

  end
end