require 'json'
require_relative 'example'
require_relative 'hashable'

include Hashable

def dejson(str)
  parsed = JSON.parse(str)
  # We've got a problem where JavaScripts JSON.stringify seems to turn an array
  # into a hash with keys of "0", "1", etc
  # I want a real array, so we'll test for this situation and return an array
  # if we find it
  if parsed.respond_to?(:keys) && parsed.keys.all? { |k| k =~ /^\d+$/ }
    parsed = parsed.keys.map(&:to_i).sort.map { |k| parsed[k.to_s] }
  end
  parsed
end

def get_example(hash_id)
  Example.find(id: unhash_it(hash_id))
end

get '/' do
  @examples = Example.order(:title).all
  haml :index
end

post '/api/v0/create_example' do
  data = dejson(request.body.read)
  example = nil
  if hash_id = data.delete('hash_id')
    example = get_example(hash_id)
  end
  return {}.to_json if example.nil? && data.empty?
  example ||= Example.find_or_create(data)
  {
    hash_id: example.hash_id,
    title: example.title,
    description: example.description,
    statement: example.statement
  }.to_json
end

get '/api/v0/sql/:hash_id' do
  example = get_example(params[:hash_id])
  { sql: example.sql }.to_json
end

get '/api/v0/diagram/:hash_id' do
  example = get_example(params[:hash_id])
  { img_src: example.image_path }.to_json
end

get '/api/v0/yaml/:hash_id' do
  example = get_example(params[:hash_id])
  { yaml: example.yaml_statement }.to_json
end
