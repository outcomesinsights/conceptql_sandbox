require_relative 'example'

%w(postgres mssql oracle).map do |dialect|
  Example.all.each do |e|
    begin
      puts "[#{dialect}] - #{e.title.chomp}"
      e.image_path(dialect)
      e.partial_results(dialect)
    rescue
      require 'pp'
      pp e.parsed_statement
      pp $!.message
      puts $!.sql
      raise
    end
  end
end
