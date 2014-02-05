require_relative 'helper'
require_relative '../models/country'

class TestCountries < ExportsImportsTest
  def test_countries_created_if_needed
    countries_before = database.execute("select count(id) from countries")[0][0]
    Country.find_or_create("China")
    countries_after = database.execute("select count(id) from countries")[0][0]
    assert_equal countries_before + 1, countries_after
  end

  def test_countries_are_not_created_if_they_already_exist
    Country.find_or_create("China")
    countries_before = database.execute("select count(id) from countries")[0][0]
    Country.find_or_create("China")
    countries_after = database.execute("select count(id) from countries")[0][0]
    assert_equal countries_before, countries_after
  end

  def test_existing_country_is_returned_by_find_or_create
    country1 = Country.find_or_create("China")
    country2 = Country.find_or_create("China")
    assert_equal country1.id, country2.id, "Country ids should be identical"
  end

  def test_create_creates_an_id
    country = Country.find_or_create("China")
    refute_nil country.id, "Country id shouldn't be nil"
  end

  def test_all_returns_all_countries_in_alphabetical_order
    Country.find_or_create("India")
    Country.find_or_create("China")
    expected = ["China", "India"]
    actual = Country.all.map{ |country| country.country }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_countries
    results = Country.all
    assert_equal [], results
  end
end