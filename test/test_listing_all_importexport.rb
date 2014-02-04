require_relative 'helper'

class TestListingExportsImports < ExportsImportsTest
  def test_returns_relevant_results
    china = ExportsImports.create(country: "China", year: 2014, month: 01, type: "e", amount: 23435)
    china = ExportsImports.create(country: "China", year: 2015, month: 01. type: "i", amount: 78239)
    france = ExportsImports.create(country: "France", year: 2014, month: 05, type: "i", amount: 9384)

    command_output = `./tradedata list --environment test`
    assert_includes_in_order command_output,
      "All ExportsImports:",
      "China: 2014, 01, e, 23435, countryid: #{china.countryid}",
      "China: 2015, 01, i, 78239, countryid: #{china.countryid}",
      "France: 2014, 05, i, 9384, countryid: #{france.countryid}"
  end
end