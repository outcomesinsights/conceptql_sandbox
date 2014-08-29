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

  def sql(dialect)
    query(dialect).sql
  rescue LoadError
    "Statement includes experimental nodes.  Cannot generate SQL statement."
  end

  def image_path(dialect)
    output_file = Pathname.new('public') + file_hash(dialect)
    file = Pathname.new(output_file.to_s + '.png')
    graph_it(dialect, parsed_statement, output_file.to_s) unless file.exist?
    file.basename.to_s
  end

  def parsed_statement
    @parsed_statement ||= JSON.parse(statement)
  end

  def yaml_statement
    @yaml_statement ||= parsed_statement.to_yaml
  end

  def partial_results(dialect)
    @partial_results ||= read_or_create_results_file(dialect)
  end

  private
  def data_db(dialect)
    @data_db ||= Sequel.connect(database_config(dialect))
  end

  def query(dialect)
    @query ||= ConceptQL::Query.new(data_db(dialect), parsed_statement)
  end

  def graph_it(dialect, statement, file)
    ConceptQL::Graph.new(statement,
                         dangler: true,
                         suffix: 'png',
                         db: data_db(dialect)
                        ).graph_it(file)
  rescue LoadError
    ConceptQL::FakeGrapher.new(suffix: 'png').graph_it(statement, file)
  end

  def file_hash(dialect)
    @file_hash ||= Digest::SHA256.hexdigest([ statement, sql(dialect), database_config(dialect) ].join)
  end

  def database_config(dialect)
    @database_config ||= Psych.load_file('config/database.yml')[dialect]
  end

  def read_or_create_results_file(dialect)
    results_dir = Pathname.new('results')
    results_dir.mkdir unless results_dir.exist?

    file_name = file_hash(dialect) + '.json'
    results_file = results_dir + file_name

    return JSON.parse(results_file.read) if results_file.exist?

    results = begin
      query(dialect).query.from_self.limit(10).all
    rescue LoadError
      [ { error: 'Query contains experimental nodes.  Cannot fetch results.' } ]
    end
    File.write(results_file, results.to_json)
    results
  end
end
