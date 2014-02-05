require_relative 'helper'

class TestListingExportsImports < ExportsImportsTest
  def test_returns_relevant_results
    ExportsImports.create(year: 2014, month: 1, type: 2, amount: 23435)
    ExportsImports.create(year: 2015, month: 1, type: 1, amount: 78239)
    ExportsImports.create(year: 2014, month: 5, type: 1, amount: 9384)

    command_output = `./tradedata list --environment test`
    assert_includes_in_order command_output,
      "All exportsimports:",
      "2014, 1, 2, 23435",
      "2015, 1, 1, 78239",
      "2014, 5, 1, 9384"
  end
end