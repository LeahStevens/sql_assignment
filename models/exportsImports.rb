class ExportsImports
  attr_accessor :country, :year, :month, :type, :amount

  def initialize attributes = {}
    [:country, :year, :month, :type, :amount].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def save
    database = Environment.database_connection
    database.execute("insert into exportsImports(country, year, month, type, amount) values('#{country}', #{year}, #{month}, #{type}, #{amount})")
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from exportsImports order by country ASC")
    results.map do |row_hash|
      ExportsImports.new(country: row_hash["country"], year: row_hash["year"], month: row_hash["month"], type: row_hash["type"], amount: row_hash["amount"])
    end
  end

  def to_s
    "#{country}: year #{year}, month #{month}, type #{type}, and amount #{amount}"
  end
end