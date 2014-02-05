require_relative 'helper'
require_relative '../models/exportsimports'

class TestExportsImports < ExportsImportsTest
  def test_country_defaults_to_unknown
    exportsimports = ExportsImports.create(country: "China", year: "2014", month: "1", type: "2", amount: "23435")
    assert_equal "Unknown", exportsimports.country.country
  end

  def test_to_s_prints_details
    exportsimports = ExportsImports.new(country: "China", year: "2014", month: "1", type: "2", amount: "23435")
    expected = "China: 2014, 1, 2, 23435, countryid: #{exportsimports.countrycountryid}"
    assert_equal expected, exportsimports.to_s
  end

def test_update_doesnt_insert_new_row
    exportsimports = ExportsImports.create(country: "China", year: "2014", month: "1", type: "2", amount: "23435")
    countries_before = database.execute("select count(countryid) from exportsimports")[0][0]
    exportsimports.update(country: "India")
    countries_after = database.execute("select count(countryid) from exportsimports")[0][0]
    assert_equal countries_before, countries_after
  end

  def test_update_saves_to_the_database
    exportsimports = ExportsImports.create(country: "China", year: "2014", month: "1", type: "2", amount: "23435")
    countryid = exportsimports.countryid
    exportsimports.update(country: "India", year: "2014", month: "2", type: "2", amount: "23435")
    updated_exportsimports = ExportsImports.find(countryid)
    expected = ["India", 2014, 1, 2, 23435]
    actual = [ updated_exportsimports.country, updated_exportsimports.month, updated_exportsimports.year, updated_exportsimports.type, updated_exportsimports.amount]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    exportsimports = ExportsImports.create(country: "China", year: "2014", month: "1", type: "2", amount: "23435")
    exportsimports.update(country: "India", year: "2014", month: "2", type: "2", amount: "23435")
    expected = ["India", 2014, 1, 2, 23435]
    actual = [ exportsimports.country, exportsimports.month, exportsimports.year, exportsimports.type, exportsimports.amount]
    assert_equal expected, actual
  end

  def test_saved_exportsimports_are_saved
    exportsimports = ExportsImports.new(country: "China", year: "2014", month: "1", type: "2", amount: "23435")
    countries_before = database.execute("select count(countryid) from exportsimports")[0][0]
    exportsimports.save
    countries_after = database.execute("select count(countryid) from exportsimports")[0][0]
    assert_equal countries_before + 1, countries_after
  end

  def test_save_creates_an_countryid
    exportsimports = ExportsImports.create(country: "China", year: "2014", month: "1", type: "2", amount: "23435")
    refute_nil exportsimports.countryid, "ExportsImports countryid shouldn't be nil"
  end

  def test_save_saves_country_countryid
    country = Country.find_or_create("China")
    exportsimports = ExportsImports.create(country: "China", year: "2014", month: "1", type: "2", amount: "23435", country: country)
    country_countryid = database.execute("select country_countryid from exportsimports where countryid='#{exportsimports.countryid}'")[0][0]
    assert_equal country.countryid, country_countryid, "Country.countryid and exportsimports.country_countryid should be the same"
  end

  def test_save_update_country_countryid
    country1 = Country.find_or_create("China")
    country2 = Country.find_or_create("Japan")
    exportsimports = ExportsImports.create(country: "China", year: "2014", month: "1", type: "2", amount: "23435", country: country1)
    exportsimports.country = country2
    exportsimports.save
    country_countryid = database.execute("select country_countryid from exportsimports where countryid='#{exportsimports.countryid}'")[0][0]
    assert_equal country2.countryid, country_countryid, "Country2.countryid and exportsimports.country_countryid should be the same"
  end

  def test_find_returns_nil_if_unfindable
    assert_nil ExportsImports.find(12342999)
  end

  def test_find_returns_the_row_as_exportsimports_object
    exportsimports = ExportsImports.create(country: "China", year: "2014", month: "1", type: "2", amount: "23435")
    found = ExportsImports.find(exportsimports.countryid)
    assert_equal exportsimports.country, found.country
    assert_equal exportsimports.countryid, found.countryid
  end

  def test_search_returns_exportsimports_objects
    ExportsImports.create(country: "China", year: 2015, month: 1, type: 2, amount: 2342)
    ExportsImports.create(country: "India", year: 2015, month: 1, type: 2, amount: 2342)
    ExportsImports.create(country: "India", year: 2015, month: 1, type: 2, amount: 2342)
    results = ExportsImports.search("India")
    assert results.all?{ |result| result.is_a? ExportsImports }, "Not all results were ExportsImports"
  end

  def test_search_returns_appropriate_results
    china = Country.find_or_create("China")

    exportsimports1 = ExportsImports.create(country: china, year: 2015, month: 1, type: 2, amount: 2342)
    exportsimports2 = ExportsImports.create(country: "India", year: 2015, month: 1, type: 2, amount: 2342)
    exportsimports3 = ExportsImports.create(country: "India", year: 2015, month: 1, type: 2, amount: 2342)

    expected = [exportsimports2, exportsimports3]
    actual = ExportsImports.search("India")

    assert_equal expected, actual
  end

  def test_all_returns_all_exportsimports_in_abc_order
    database.execute("insert into ExportsImports(country, year, month, type, amount) values('China', 2014, 1, 2, 23435)")
    database.execute("insert into ExportsImports(country, year, month, type, amount) values('China', 2015, 1, 1, 78239)")
    results = ExportsImports.all
    expected = ["China", "China"]
    actual = results.map{ |exportsimports| exportsimports.country }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_exportsimports
    results = ExportsImports.all
    assert_equal [], results
  end

  def test_equality_on_same_object
    exportsimports = ExportsImports.create(country: "China", year: 2015, month: 1, type: 2, amount: 2342)
    assert exportsimports == exportsimports
  end

  def test_equality_with_different_class
    exportsimports = ExportsImports.create(country: "China", year: 2015, month: 1, type: 2, amount: 2342)
    refute exportsimports == "ExportsImports"
  end

  def test_equality_with_different_exportsimports
    exportsimports1 = ExportsImports.create(country: "China", year: 2015, month: 1, type: 2, amount: 2342)
    exportsimports2 = ExportsImports.create(country: "India", year: 2015, month: 1, type: 2, amount: 2342)
    refute exportsimports1 == exportsimports2
  end

  def test_equality_with_same_exportsimports_different_object_countryid
    exportsimports1 = ExportsImports.create(country: "China", year: 2015, month: 1, type: 2, amount: 2342)
    exportsimports2 = ExportsImports.find(exportsimports1.countryid)
    assert exportsimports1 == exportsimports2
  end
end