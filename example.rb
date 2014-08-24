require 'sequel'
require 'digest'
require 'psych'
require 'json'
require 'conceptql/query'
require 'conceptql/graph'
require 'conceptql/fake_grapher'
require_relative 'hashable'

Sequel::Model.db = Sequel.connect(Psych.load_file('config/database.yml')['site_data'])
class Example < Sequel::Model
  include Hashable

  def hash_id
    hash_it(id)
  end

  def sql
    ConceptQL::Query.new(data_db, parsed_statement).sql
  end

  def image_path
    output_file = Pathname.new('public') + image_hash
    file = Pathname.new(output_file.to_s + '.png')
    graph_it(parsed_statement, output_file.to_s) unless file.exist?
    file.basename.to_s
  end

  def parsed_statement
    @parsed_statement ||= JSON.parse(statement)
  end

  def yaml_statement
    @yaml_statement ||= parsed_statement.to_yaml
  end

  private
  def data_db
    @data_db ||= Sequel.connect(Psych.load_file('config/database.yml')['data'])
  end

  def graph_it(statement, file)
    ConceptQL::Graph.new(statement,
                         dangler: true,
                         suffix: 'png',
                         db: data_db
                        ).graph_it(file)
  rescue LoadError
    ConceptQL::FakeGrapher.new(suffix: 'png').graph_it(statement, file)
  end

  def image_hash
    @image_hash ||= Digest::SHA256.hexdigest([ statement, sql, database_config ].join)
  end

  def database_config
    Psych.load_file('config/database.yml')['data']
  end
end
