require_relative 'helper'
require_relative '../models/exportsimports'

class TestExportsImports < ExportsImportsTest
  def test_to_s_prints_details
    exportsImports = ExportsImports.new(country: "China", year: "2014", month: "01", type: "e", amount: "23435")
    expected = "China: year 2014, month 01, type e, amount 23435"
    assert_equal expected, exportsImports.to_s
  end

  def test_all_returns_all_exportsimports_in_abc_order
    database.execute("insert into exportsImports(country, year, month, type, amount) values('China', 2014, 01, 'e', 23435)")
    database.execute("insert into exportsImports(country, year, month, type, amount) values('China', 2015, 01, 'i', 78239)")
    results = ExportsImports.all
    expected = ["China", "China"]
    actual = results.map{ |purchase| purchase.name }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_exportsimports
    results = ExportsImports.all
    assert_equal [], results
  end
end