require 'pry'
class ExportsImports
  attr_accessor :country, :year, :month, :type, :amount
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
    self.country ||= Country.default
  end

  # def country=(country)
  #   @country = country
  # end

   def year=(year)
    @year = year.to_i
  end

  def month=(month)
    @month = month.to_i
  end

  def type=(type)
    @type = type
  end

  def amount=(amount)
    @amount = amount.to_i
  end


  def self.create(attributes = {})
    exportsimports = ExportsImports.new(attributes)
    exportsimports.save
    exportsimports
  end

  def update attributes = {}
    update_attributes(attributes)
    save
  end

  def save
    database = Environment.database_connection
    country_id = country.nil? ? "NULL" : country.id
    if id
      database.execute("update exportsimports set year = '#{year}', month = '#{month}', type = '#{type}', amount = '#{amount}' ")
    else
      database.execute("insert into exportsimports(year, month, type, amount) values(#{year}, #{month}, #{type}, #{amount})")
     @id = database.last_insert_row_id
    end
  end

def self.find id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from exportsimports where id = #{id}")[0]
    if results
      exportsimports = ExportsImports.new(country: results["country"], year: results["year"], month: results["month"], type: results["type"], amount: results["amount"])
      exportsimports.send("id=", results["id"])
      exportsimports
    else
      nil
    end
  end

  def self.search(search_term = nil)
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from exportsimports where year LIKE '%#{search_term}%' order by year ASC")
    results.map do |row_hash|
      exportsimports = ExportsImports.new(
        country: row_hash["country"],
        year: row_hash["year"],
        month: row_hash["month"],
        type: row_hash["type"],
        amount: row_hash["amount"])
      # Why is this not ideal?
      country = Country.all.find{|country| country.id == row_hash["country_id"]}
      exportsimports.country = country
      exportsimports.send("id=", row_hash["country.id"])
      exportsimports
    end
  end

  def self.all
    search
  end

  def to_s
    "#{country.country}: year #{year}, month #{month}, type #{type}, and amount #{amount}"
  end


  def ==(other)
    other.is_a?() && self.to_s == other.to_s
  end
# And what does protected mean?
  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    [:country, :year, :month, :type, :amount].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end
