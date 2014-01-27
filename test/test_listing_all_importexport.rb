require_relative 'helper'

class TestListingExportsImports < ExportsImportsTest
  def test_returns_relevant_results
    `./exportsImports add China --year 2014 --month 01 --type e --amount 23435`
    `./exportsImports add China --year 2015 --month 01 --type i --amount 78239`
    `./exportsImports add France --year 2014 --month 05 --type i --amount 9384`

    command = "./exportsImports list"
    expected = <<EOS.chomp
All Exports/Imports:
China: 2014, 01, e, 23435
China: 2015, 01, i, 78239
France: 2014, 05, i, 9384
EOS
    assert_command_output expected, command
  end
end