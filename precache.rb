require_relative 'example'

%w(postgres mssql oracle).map do |dialect|
  Example.all.each do |e|
    begin
      start = Time.now
      print "[#{dialect}] - #{e.title.chomp}"
      e.image_path(dialect)
      e.pdf_path(dialect)
      e.partial_results(dialect)
      e.sql(dialect)
      elapsed = Time.now - start
      puts " - #{elapsed}"
    rescue Sequel::DatabaseError
      require 'pp'
      pp e.parsed_statement
      pp $!.message
      puts $!.sql
      raise
    end
  end
end
