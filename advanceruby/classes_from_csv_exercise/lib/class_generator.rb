class ClassGenerator

  def self.create_class(klass_name, method_names)
    klass = Object.const_set(klass_name, Class.new)
    generate_initialize(klass, method_names)
    genrate_methods(klass, method_names)
    klass
  end

  def self.create_objects(klass, rows)
    row_to_object_reference = {}
    rows.each { |row| row_to_object_reference[row.field("name")] = klass.new(row.to_hash) }
    row_to_object_reference
  end

  private
    def self.genrate_methods(klass, method_names)
      generate_initialize(klass, method_names)
      method_names.each do |method_name|
        klass.class_eval do
          attr_reader "#{ method_name }".to_sym
        end
      end
    end

    def self.generate_initialize(klass, instance_variables)
      klass.class_eval do
        define_method("initialize") do |args_hash|
          args_hash.each do |key, value|
            instance_variable_set("@#{ key.to_s }", value)
          end
        end
      end
    end

end