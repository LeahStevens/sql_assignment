#!/usr/bin/env ruby
# -*- ruby -*-

require_relative 'lib/environment'
require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

task :bootstrap_database do
  require 'sqlite3'
  database = Environment.database_connection("production")
  create_tables(database)
end

task :test_prepare do
  require 'sqlite3'
  File.delete("db/exportsImports_test.sqlite3")
  database = Environment.database_connection("test")
  create_tables(database)
end

def create_tables(database_connection)
  database_connection.execute("CREATE TABLE exportsImports (id INTEGER PRIMARY KEY AUTOINCREMENT, country varchar(255), year integer, month integer, type bit(i/e), amount integer")
end