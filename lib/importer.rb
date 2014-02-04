require 'csv'

class Importer
  def self.import(from_filename)
    CSV.foreach(from_filename, headers: true) do |row_hash|
      import_product(row_hash)
    end
  end

  def self.import_product(row_hash)
    country = Country.find_or_create(row_hash["CTYNAME"])

    exportsimports = ExportsImports.create(
      country: country,
      year: row_hash["year"],
      month: row_hash["month"],
      type: row_hash["type"],
      amount: row_hash["amount"]
    )
  end
end