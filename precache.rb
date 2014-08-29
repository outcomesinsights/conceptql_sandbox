require_relative 'example'

%w(postgres oracle).each do |dialect|
  Example.all.each do |e|
    begin
    puts e.title
      puts dialect
      e.image_path(dialect)
      e.partial_results(dialect)
    rescue
      require 'pp'
      pp e.parsed_statement
      raise
    end
  end
end
