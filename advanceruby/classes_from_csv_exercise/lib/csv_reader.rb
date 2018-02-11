require 'csv'

class CsvReader

  attr_accessor :file_path, :file_name, :column_names

  def initialize(file_path)
    @file_path = file_path
    @file_name = extract_filename
    @column_names = extract_column_name
  end

  def data
    rows = []
    CSV.foreach(@file_path, headers: true) { |row| row.header_row? ? nil : rows << row }
    rows
  end

  private

    def extract_filename
      filename = @file_path.split("/")[-1].split(".")[-2].capitalize
    end

    def extract_column_name
      column_names = CSV.read(@file_path)[0].map { |column_name| column_name.downcase }
    end

end