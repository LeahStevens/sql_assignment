require 'pry'

class Country
  attr_accessor :country
  attr_reader :id

  def self.default
    @@default ||= Country.find_or_create("Unknown")
  end

  def initialize(country)
    self.country = country
  end

  def country=(country)
    # There was a .strip after @country = country.strip
    # It kept killing my code.
    @country = country
    # binding.pry
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from countries order by country ASC")
    results.map do |row_hash|
      country = Country.new(country: row_hash["country"])
      country.send("id=", row_hash["country.id"])
      country
    end
  end

  def self.find_or_create name
    database = Environment.database_connection
    database.results_as_hash = true
    country = Country.new(name)
    results = database.execute("select * from countries where country = '#{name}'")

    if results.empty?
      database.execute("insert into countries(country) values('#{name}')")
      country.send("id=", database.last_insert_row_id)
    else
      row_hash = results[0]
      country.send("id=", row_hash["id"])
    end
    country
  end

  protected

  def id=(id)
    @id = id
  end
end