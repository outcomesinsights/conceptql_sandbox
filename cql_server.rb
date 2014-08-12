require 'conceptql/query'
require 'conceptql/fake_grapher'
require 'sequelizer'
require 'digest'
require 'json'

def graph_it(statement, file)
  ConceptQL::FakeGrapher.new(suffix: 'png').graph_it(statement, file)
end

include Sequelizer
get '/' do
  @statements = Pathname.new('statements').children.map do |dir|
    next unless dir.directory? && !dir.children.empty?
    files = dir.children.reject { |f| f.basename.to_s =~ /^\./ }.map do |f|
      description = File.readlines(f).reject { |l| l !~ /^#/ }.map { |l| l.gsub('#', '').chomp.strip }.first
      [f.to_s, description]
    end
    [dir.basename.to_s, files]
  end.compact
  @statements = Hash[@statements]
  haml :index
end

get '/statements.json' do
  puts params
  file_path = params[:path]
  hash = eval(File.read(file_path))
  { statement: hash }.to_json
end

post '/statement' do
  statement = JSON.parse request.body.read
  sql = ""
  begin
    sql = ConceptQL::Query.new(db, statement).query.sql
  rescue LoadError
    sql = "One of the nodes in your statement appears to be experimental.  Cannot generate SQL statement."
  end
  digest = Digest::SHA256.hexdigest statement.to_s
  output_file = Pathname.new('public') + digest
  graph_it(statement, output_file.to_s)
  {
    status: 'success',
    query: sql,
    yaml: statement.to_yaml,
    img_src: "#{digest}.png"
  }.to_json
end
