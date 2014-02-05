require_relative 'helper'
require_relative '../lib/importer'

class TestImportingExportsImports < ExportsImportsTest
  def import_data
    Importer.import("data/tradedataetc.csv")
  end

  def test_the_correct_number_of_exportsimports_are_imported
    import_data
    assert_equal 4, ExportsImports.all.count
  end

  def test_exportsimports_are_imported_fully
    import_data
    expected = [
      "China, 2014, 1, 2, 23423",
      "Australia, 2015, 1, 1, 123",
      "India, 2024, 1, 2, 923423",
    ]
    actual = ExportsImports.all.map do |exportsimports|
      "#{exportsimports.country}, #{exportsimports.year}, #{exportsimports.month}, #{exportsimports.type}, #{exportsimports.amount}"
    end
    assert_equal expected, actual
  end

  def test_extra_countries_arent_created
    import_data
    assert_equal 3, Country.all.count
  end

  def test_countries_are_created_as_needed
    Country.find_or_create("China")
    Country.find_or_create("India")
    import_data
    assert_equal 4, Country.all.count, "The countries were: #{Country.all.map(&:country)}"
  end

  def test_data_isnt_duplicated
    import_data
    expected = ["China", "India", "Japan"]
    assert_equal expected, Country.all.map(&:country)
  end
end