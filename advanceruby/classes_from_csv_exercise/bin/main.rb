require_relative '../lib/class_generator.rb'
require_relative '../lib/csv_reader.rb'

file_path = Dir.pwd + '/../data/employee.csv'

csv_reader = CsvReader.new(file_path)

klass = ClassGenerator.create_class(csv_reader.file_name, csv_reader.column_names)

rows = csv_reader.data

x = ClassGenerator.create_objects(klass, rows)

puts x