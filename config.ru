require 'rubygems'
require 'bundler'
Bundler.require

require './conceptql_sandbox.rb'
run Sinatra::Application
