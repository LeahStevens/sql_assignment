#!/usr/bin/env ruby
# -*- ruby -*-

require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

task :bootstrap_database do
  require 'sqlite3'
  database = SQLite3::Database.new("imports_exports")
  database.execute("CREATE TABLE ExportsImports (id INTEGER PRIMARY KEY AUTOINCREMENT, countryid int, year int, month int, type bit(i/e), amount int")
end