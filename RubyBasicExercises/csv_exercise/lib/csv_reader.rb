require 'csv'

class CSVReader
  def self.read_csv_data(filepath)
    hash = Hash.new() {|h, k| h[k] = [] }
    CSV.foreach(filepath, headers: true) do |row|
      hash[row.fetch(Designation)] << "#{ row[Name] } (#{ row[EmpId] })"
    end
    hash.sort.to_h
  end

  def self.write_data_from(file_to_read)
    hash = read_csv_data(file_to_read)
    file = File.open('./csv_exercise/data/output_data', 'w')
    hash.each_key do |key|
      hash[key].length > 1? (file.puts "#{ key }s") : (file.puts key)
      file.puts hash[key]
      file.puts
    end
  end

end
