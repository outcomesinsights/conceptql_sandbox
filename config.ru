require 'rubygems'
require 'bundler'
Bundler.require

require './cql_server.rb'
run Sinatra::Application
