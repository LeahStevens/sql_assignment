require_relative 'database'
require_relative '../models/exportsImports'
require 'logger'

class Environment
  def self.environment= environment
    @@environment = environment
  end

  def self.database_connection
    Database.connection(@@environment)
  end

  def self.logger
    @@loger ||= Logger.new("logs/#{@@environment}.log")
  end
end