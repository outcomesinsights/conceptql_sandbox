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
    query.sql
  rescue LoadError
    "Statement includes experimental nodes.  Cannot generate SQL statement."
  end

  def image_path
    output_file = Pathname.new('public') + file_hash
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

  def partial_results
    @partial_results ||= read_or_create_results_file
  end

  private
  def data_db
    @data_db ||= Sequel.connect(Psych.load_file('config/database.yml')['data'])
  end

  def query
    @query ||= ConceptQL::Query.new(data_db, parsed_statement)
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

  def file_hash
    @file_hash ||= Digest::SHA256.hexdigest([ statement, sql, database_config ].join)
  end

  def database_config
    Psych.load_file('config/database.yml')['data']
  end

  def read_or_create_results_file
    results_dir = Pathname.new('results')
    results_dir.mkdir unless results_dir.exist?

    file_name = file_hash + '.json'
    results_file = results_dir + file_name

    return JSON.parse(results_file.read) if results_file.exist?

    results = begin
      query.query.from_self.limit(10).all
    rescue LoadError
      [ { error: 'Query contains experimental nodes.  Cannot fetch results.' } ]
    end
    File.write(results_file, results.to_json)
    results
  end
end
