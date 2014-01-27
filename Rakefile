#!/usr/bin/env ruby
# -*- ruby -*-

require_relative 'lib/environment'
require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc `running tests`
task :default => :test

desc 'production db setup'
task :bootstrap_database do
  Environment.environment = "production"
  database = Environment.database_connection
  create_tables(database)
end

desc `prepare test db`
task :test_prepare do
  File.delete("db/exportsimports_test.sqlite3")
  Environment.environment = 'test'
  database = Environment.database_connection
  create_tables(database)
end

def create_tables(database_connection)
  database_connection.execute("CREATE TABLE exportsImports (id INTEGER PRIMARY KEY AUTOINCREMENT, country varchar(255), year integer, month integer, type bit(i/e), amount integer")
end