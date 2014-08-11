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
  @statements = Pathname.new('statements').children.map { |f| f.basename('.*').to_s }.reject { |f| f =~ /^\./ }
  haml :index
end

get '/:name' do
  { statement: File.read('statements/' + params[:name]) }.to_json
end

post '/statement' do
  statement = JSON.parse request.body.read
  cq = ConceptQL::Query.new(db, statement)
  digest = Digest::SHA256.hexdigest statement.to_s
  output_file = Pathname.new('public') + digest
  graph_it(statement, output_file.to_s)
  {
    status: 'success',
    query: cq.query.sql,
    img_src: "#{digest}.png"
  }.to_json
end
