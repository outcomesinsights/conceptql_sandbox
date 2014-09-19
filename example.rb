require 'sequel'
require 'digest'
require 'psych'
require 'json'
require 'conceptql/query'
require 'conceptql/version'
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
    @sql ||= cached_to_file(dialect, 'sql') do
      begin
        query(dialect).sql
      rescue LoadError
        "Statement includes experimental nodes.  Cannot generate SQL statement."
      end
    end
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
    @partial_results ||= cached_to_file(dialect, 'json') do
      begin
        query(dialect).query.from_self.limit(10).all
      rescue LoadError
        [ { error: 'Query contains experimental nodes.  Cannot fetch results.' } ]
      end
    end
  end

  private
  def data_db(dialect)
    @data_db ||= Sequel.connect(database_config(dialect)).tap { |db| db.extension :error_sql }
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
    @file_hash ||= Digest::SHA256.hexdigest([ statement, ConceptQL::VERSION, dialect, database_config(dialect) ].join)
  end

  def database_config(dialect)
    @database_config ||= Psych.load_file('config/database.yml')[dialect]
  end

  def cached_to_file(dialect, extension)
    file = file_path(dialect, extension)
    if file.exist?
      content = file.read
      content = JSON.parse(content) if extension == 'json'
      return content
    end
    results = yield
    if extension == 'json'
      File.write(file, results.to_json)
    else
      File.write(file, results)
    end
    results
  end

  def file_path(dialect, extension)
    results_dir = Pathname.new('results')
    results_dir.mkdir unless results_dir.exist?

    file_name = file_hash(dialect) + ".#{extension}"
    results_dir + file_name
  end
end
